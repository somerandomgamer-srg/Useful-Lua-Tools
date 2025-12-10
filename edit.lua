local database = {}

local function getDbParams()
    local url = os.getenv("DATABASE_URL")
    if not url then error("DATABASE_URL environment variable not found!") end
    return url
end

local function execQueryInternal(query, variables)
    local url = getDbParams()
    variables = variables or {}

    -- Escape a string for shell safety (prevent command injection)
    local function shell_escape(str)
        -- Replace single quotes with '\''
        return "'" .. string.gsub(tostring(str), "'", "'\"'\"'") .. "'"
    end

    -- Replace variables in the query using psql variable syntax
    local processed_query = query
    local psql_vars = {}

    for key, value in pairs(variables) do
        -- Replace :key with :'key' (quoted psql variable reference)
        processed_query = processed_query:gsub(":" .. key, ":'var_" .. key .. "'")
        -- Store the variable for psql -v parameter
        table.insert(psql_vars, "-v")
        table.insert(psql_vars, "var_" .. key .. "=" .. shell_escape(value))
    end

    -- Create a unique temporary file for the query
    local temp_file = "/tmp/query_" .. os.time() .. "_" .. math.random(1000) .. ".sql"
    local file = io.open(temp_file, "w")
    if not file then
        return false, "Failed to create temporary query file"
    end

    file:write(processed_query)
    file:close()

    -- Build psql command with secure variable passing
    local command_parts = { 'psql', '"' .. db_url .. '"', '-f', temp_file, '-t', '-A', '-F', '"|"',
        '--set=ON_ERROR_STOP=1' }

    -- Add variable assignments
    for i = 1, #psql_vars do
        table.insert(command_parts, psql_vars[i])
    end

    local command = table.concat(command_parts, " ")

    local handle = io.popen(command .. " 2>&1")
    if not handle then
        os.remove(temp_file)
        return false, "Failed to execute database command"
    end

    local result = handle:read("*a")
    local success, exit_type, exit_code = handle:close()

    -- Clean up temporary file
    os.remove(temp_file)

    -- Use actual exit code to determine success, not stdout content
    if success then
        -- Query succeeded, return cleaned result (empty string if no output)
        return true, (result and result ~= "") and result:gsub("^%s*(.-)%s*$", "%1") or ""
    else
        -- Query failed, return error message
        return false, "Query execution failed: exit_code=" .. tostring(exit_code) .. " result=" .. tostring(result)
    end
end

---Execute a simple SQL query without parameters
---@param query string SQL query to execute
---@return boolean success True if query executed successfully, false otherwise
---@return string result Query result or error message
---
---Example:
---  local ok, result = database.execute_query("SELECT version();")
---  if ok then
---    print("Database version:", result)
---  else
---    print("Query failed:", result)
---  end
function database.execute_query(query)
    return execQueryInternal(query)
end

---Initialize the database schema with proper tables, constraints, and security features
---Sets up both high_scores and users tables with indexes, triggers, and pgcrypto extension
---This should be called once when first setting up the database
---@return boolean success True if schema was initialized successfully, false otherwise
---@return string|nil error Error message if initialization failed
---
---Example:
---  local ok, err = database.initialize_schema()
---  if ok then
---    print("Database schema initialized successfully")
---  else
---    print("Schema initialization failed:", err)
---  end
function database.initialize_schema()
    -- First, enable pgcrypto extension
    local extension_sql = "CREATE EXTENSION IF NOT EXISTS pgcrypto;"
    local ext_ok, ext_result = execQueryInternal(extension_sql)
    if not ext_ok then
        return false, "Failed to enable pgcrypto: " .. (ext_result or "Unknown error")
    end

    -- Create high_scores table
    local high_scores_sql = [[
CREATE TABLE IF NOT EXISTS high_scores (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    high_score INTEGER DEFAULT 0 CHECK (high_score >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
]]
    local hs_ok, hs_result = execQueryInternal(high_scores_sql)
    if not hs_ok then
        return false, "Failed to create high_scores table: " .. (hs_result or "Unknown error")
    end

    -- Handle users table migration
    local migration_success, migration_error = database.migrate_users_table()
    if not migration_success then
        return false, migration_error
    end

    -- Create indexes and triggers
    local indexes_sql = [[
-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_high_scores_score ON high_scores(high_score DESC);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_score ON users(high_score DESC);

-- Create function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers to automatically update updated_at
DROP TRIGGER IF EXISTS update_high_scores_updated_at ON high_scores;
CREATE TRIGGER update_high_scores_updated_at
    BEFORE UPDATE ON high_scores
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_users_updated_at ON users;
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
]]

    local idx_ok, idx_result = execQueryInternal(indexes_sql)
    if not idx_ok then
        return false, "Failed to create indexes and triggers: " .. (idx_result or "Unknown error")
    end

    return true
end

---Migrate users table from old structure to new secure structure with password hashing
---Handles both creating new users table and updating existing ones to include security features
---This is called automatically by initialize_schema() and handles backward compatibility
---@return boolean success True if migration completed successfully, false otherwise
---@return string|nil error Error message if migration failed
---
---Example:
---  local ok, err = database.migrate_users_table()
---  if ok then
---    print("Users table migration successful")
---  else
---    print("Migration failed:", err)
---  end
function database.migrate_users_table()
    -- Check if users table exists and what columns it has
    local check_table_sql = [[
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'users' AND table_schema = 'public'
ORDER BY ordinal_position;
]]

    local columns_ok, columns_result = execQueryInternal(check_table_sql)

    if not columns_ok or columns_result == "" then
        -- Table doesn't exist, create new secure table
        local create_users_sql = [[
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    high_score INTEGER DEFAULT 0 CHECK (high_score >= 0),
    is_admin BOOLEAN DEFAULT FALSE,
    games_played INTEGER DEFAULT 0 CHECK (games_played >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
]]
        local create_ok, create_result = execQueryInternal(create_users_sql)
        if not create_ok then
            return false, "Failed to create users table: " .. (create_result or "Unknown error")
        end
        return true
    end

    -- Check if we have the password_hash column
    local has_password_hash = columns_result:find("password_hash") ~= nil

    if not has_password_hash then
        -- Add password_hash column if it doesn't exist
        local add_column_sql = "ALTER TABLE users ADD COLUMN password_hash TEXT;"
        local add_ok, add_result = execQueryInternal(add_column_sql)
        if not add_ok then
            return false, "Failed to add password_hash column: " .. (add_result or "Unknown error")
        end
    end

    -- Ensure all required columns exist with proper constraints
    local ensure_columns_sql = [[
ALTER TABLE users
    ADD COLUMN IF NOT EXISTS high_score INTEGER DEFAULT 0,
    ADD COLUMN IF NOT EXISTS is_admin BOOLEAN DEFAULT FALSE,
    ADD COLUMN IF NOT EXISTS games_played INTEGER DEFAULT 0,
    ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Add constraints if they don't exist
DO $$
BEGIN
    -- Add check constraints
    IF NOT EXISTS (SELECT 1 FROM information_schema.check_constraints WHERE constraint_name = 'users_high_score_check') THEN
        ALTER TABLE users ADD CONSTRAINT users_high_score_check CHECK (high_score >= 0);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.check_constraints WHERE constraint_name = 'users_games_played_check') THEN
        ALTER TABLE users ADD CONSTRAINT users_games_played_check CHECK (games_played >= 0);
    END IF;

    -- Ensure username is unique
    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE constraint_name = 'users_username_key') THEN
        ALTER TABLE users ADD CONSTRAINT users_username_key UNIQUE (username);
    END IF;
EXCEPTION
    WHEN others THEN
        -- Constraints may already exist, continue
        NULL;
END $$;
]]

    local ensure_ok, ensure_result = execQueryInternal(ensure_columns_sql)
    if not ensure_ok then
        return false, "Failed to ensure all required columns and constraints: " .. (ensure_result or "Unknown error")
    end

    -- Type normalization step: ensure games_played is INTEGER type
    local type_normalization_sql = [[
DO $$
BEGIN
    -- Check if games_played column exists and normalize its type to INTEGER
    IF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'users' 
        AND column_name = 'games_played' 
        AND table_schema = 'public'
        AND data_type != 'integer'
    ) THEN
        -- Safely convert games_played to INTEGER, defaulting invalid values to 0
        ALTER TABLE users 
        ALTER COLUMN games_played TYPE INTEGER 
        USING (
            CASE 
                WHEN games_played IS NULL THEN 0
                WHEN games_played ~ '^\s*\d+\s*$' THEN games_played::integer 
                ELSE 0 
            END
        );

        -- Set proper default and constraints after type conversion
        ALTER TABLE users ALTER COLUMN games_played SET DEFAULT 0;
        ALTER TABLE users ALTER COLUMN games_played SET NOT NULL;
    END IF;

    -- Similar check for high_score to ensure it's INTEGER
    IF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'users' 
        AND column_name = 'high_score' 
        AND table_schema = 'public'
        AND data_type != 'integer'
    ) THEN
        ALTER TABLE users 
        ALTER COLUMN high_score TYPE INTEGER 
        USING (
            CASE 
                WHEN high_score IS NULL THEN 0
                WHEN high_score ~ '^\s*\d+\s*$' THEN high_score::integer 
                ELSE 0 
            END
        );

        ALTER TABLE users ALTER COLUMN high_score SET DEFAULT 0;
        ALTER TABLE users ALTER COLUMN high_score SET NOT NULL;
    END IF;
END $$;
]]

    local normalize_ok, normalize_result = execQueryInternal(type_normalization_sql)
    if not normalize_ok then
        return false, "Failed to normalize column types: " .. (normalize_result or "Unknown error")
    end

    return true
end

---Add or update a user's high score in the simple high_scores table
---Uses the higher score if user already exists (keeps the best score)
---@param username string Username to add/update (1-50 characters, cannot be empty)
---@param score number Score to set (must be non-negative integer)
---@return boolean success True if score was added/updated successfully, false otherwise
---@return string result Query result on success (usually empty string), error message on failure
---
---Example:
---  local ok, err = database.add_high_score("player1", 150)
---  if ok then
---    print("High score added!")
---  else
---    print("Failed to add score:", err)
---  end
function database.add_high_score(username, score)
    -- Validate inputs
    if not username or username == "" then
        return false, "Username cannot be empty"
    end
    if not score or score < 0 then
        return false, "Score must be a non-negative number"
    end

    local query = [[
INSERT INTO high_scores (username, high_score)
VALUES (:username, :score)
ON CONFLICT (username)
DO UPDATE SET high_score = GREATEST(high_scores.high_score, EXCLUDED.high_score), updated_at = CURRENT_TIMESTAMP;
]]

    local variables = {
        username = username,
        score = score
    }

    return execQueryInternal(query, variables)
end

---Get the high score for a specific user from the simple high_scores table
---@param username string Username to look up (cannot be empty)
---@return number score User's high score (0 if user not found)
---@return string|nil error Error message if lookup failed
---
---Example:
---  local score, err = database.get_high_score("player1")
---  if err then
---    print("Error:", err)
---  else
---    print("Player1's high score:", score)
---  end
function database.get_high_score(username)
    if not username or username == "" then
        return 0, "Username cannot be empty"
    end

    local query = "SELECT high_score FROM high_scores WHERE username = :username;"
    local variables = { username = username }

    local ok, result = execQueryInternal(query, variables)
    if not ok then
        return 0, result -- result contains error message
    end
    if result and result ~= "" then
        return tonumber(result) or 0
    end
    return 0
end

---Get all high scores sorted by score (descending) for leaderboard display
---Returns top 10 scores from the simple high_scores table
---@return table scores Array of {username, score} tables sorted by score
---@return string|nil error Error message if query failed
---
---Example:
---  local scores, err = database.get_all_high_scores()
---  if err then
---    print("Error:", err)
---  else
---    for i, entry in ipairs(scores) do
---      print(i, entry.username, entry.score)
---    end
---  end
function database.get_all_high_scores()
    local query = "SELECT username, high_score FROM high_scores ORDER BY high_score DESC LIMIT 10;"
    local ok, result = execQueryInternal(query)

    local scores = {}
    if not ok then
        return {}, result -- result contains error message
    end
    if result and result ~= "" then
        for line in result:gmatch("[^\r\n]+") do
            local username, score = line:match("([^|]+)|([^|]+)")
            if username and score then
                table.insert(scores, { username = username, score = tonumber(score) })
            end
        end
    end
    return scores
end

---Get all users sorted by games played (descending) for games played leaderboard display
---Returns top 10 most active players from the comprehensive users table
---@return table players Array of {username, games_played, high_score} tables sorted by games played
---@return string|nil error Error message if query failed
---
---Example:
---  local players, err = database.get_games_played_leaderboard()
---  if err then
---    print("Error:", err)
---  else
---    for i, player in ipairs(players) do
---      print(i, player.username, "Games:", player.games_played, "High Score:", player.high_score)
---    end
---  end
function database.get_games_played_leaderboard()
    local query = "SELECT username, games_played, high_score FROM users ORDER BY games_played DESC LIMIT 10;"
    local ok, result = execQueryInternal(query)

    local players = {}
    if not ok then
        return {}, result -- result contains error message
    end
    if result and result ~= "" then
        for line in result:gmatch("[^\r\n]+") do
            local username, games_played, high_score = line:match("([^|]+)|([^|]+)|([^|]+)")
            if username and games_played and high_score then
                table.insert(players, {
                    username = username,
                    games_played = tonumber(games_played),
                    high_score = tonumber(high_score)
                })
            end
        end
    end
    return players
end

---Create a new user account with secure password hashing in the comprehensive users table
---@param username string Username (1-50 characters, must be unique)
---@param password string Password (minimum 6 characters, will be securely hashed)
---@param is_admin boolean|nil Whether user should have admin privileges (optional, defaults to false)
---@return boolean success True if user was created successfully, false otherwise
---@return string result Query result on success (usually empty string), error message on failure
---
---Example:
---  local ok, err = database.create_user("newplayer", "mypassword", false)
---  if ok then
---    print("User created successfully!")
---  else
---    print("Failed to create user:", err)
---  end
function database.create_user(username, password, is_admin)
    -- Validate inputs
    if not username or username == "" then
        return false, "Username cannot be empty"
    end
    if not password or password == "" then
        return false, "Password cannot be empty"
    end
    if #username > 50 then
        return false, "Username too long (max 50 characters)"
    end
    if #password < 6 then
        return false, "Password too short (minimum 6 characters)"
    end

    is_admin = is_admin or false

    -- Use a more robust query that handles potential column variations
    local query = [[
INSERT INTO users (username, password_hash, is_admin, high_score, games_played)
VALUES (:username, crypt(:password, gen_salt('bf')), :is_admin, 0, 0);
]]

    local variables = {
        username = username,
        password = password,
        is_admin = is_admin
    }

    return execQueryInternal(query, variables)
end

---Authenticate a user with secure password verification using bcrypt hashing
---@param username string Username to authenticate (cannot be empty)
---@param password string Password to verify (cannot be empty)
---@return boolean success True if authentication successful, false for invalid credentials or database error
---@return string|nil error Error message only for database/connection errors (nil for wrong credentials)
---
---Example:
---  local ok, err = database.authenticate_user("player1", "mypassword")
---  if ok then
---    print("Login successful!")
---  elseif err then
---    print("Database error:", err)
---  else
---    print("Invalid username or password") -- This is normal, not an error
---  end
function database.authenticate_user(username, password)
    if not username or username == "" then
        return false, "Username cannot be empty"
    end
    if not password or password == "" then
        return false, "Password cannot be empty"
    end

    local query = [[
SELECT EXISTS(
    SELECT 1 FROM users
    WHERE username = :username
    AND password_hash = crypt(:password, password_hash)
);
]]

    local variables = {
        username = username,
        password = password
    }

    local ok, result = execQueryInternal(query, variables)
    if not ok then
        return false, result -- result contains error message
    end
    return result == "t"     -- PostgreSQL returns 't' for true, 'f' for false
end

---Update a user's high score and increment games played counter
---Only updates high score if new score is higher than current score
---@param username string Username to update (cannot be empty)
---@param new_score number New score to compare/set (must be non-negative)
---@return boolean success True if update successful, false otherwise
---@return string result Query result on success (usually empty string), error message on failure
---
---Example:
---  local ok, err = database.update_user_score("player1", 200)
---  if ok then
---    print("Score updated and games played incremented!")
---  else
---    print("Failed to update score:", err)
---  end
function database.update_user_score(username, new_score, games_played)
    if not username or username == "" then
        return false, "Username cannot be empty"
    end
    if not new_score or new_score < 0 then
        return false, "Score must be a non-negative number"
    end
    if not games_played or games_played < 0 then
        return false, "games_played must be a non-negative number"
    end

    local query = [[
UPDATE users
SET high_score = GREATEST(high_score, :new_score),
    games_played = games_played + 1,
    updated_at = CURRENT_TIMESTAMP
WHERE username = :username;
]]

    local variables = {
        username = username,
        new_score = new_score
    }

    return execQueryInternal(query, variables)
end

---Get comprehensive information about a user from the users table
---@param username string Username to look up (cannot be empty)
---@return table|nil userInfo Table containing {username, high_score, is_admin, games_played, is_privilaged} or nil if not found
---@return string|nil error Error message if lookup failed
---
---Example:
---  local user, err = database.get_user_info("player1")
---  if err then
---    print("Error:", err)
---  elseif user then
---    print("User:", user.username, "Score:", user.high_score, "Games:", user.games_played)
---  else
---    print("User not found")
---  end
function database.getUserInfo(username)
    if not username or username == "" then return nil, "Username cannot be empty" end

    local query = [[
SELECT username, high_score, is_admin, games_played, is_privilaged
FROM users
WHERE username = :username;
]]

    local variables = { username = username }
    local ok, result = execQueryInternal(query, variables)

    if not ok then return nil, result end

    if result and result ~= "" then
        local parts = {}
        for part in result:gmatch("[^|]+") do table.insert(parts, part) end

        if #parts >= 4 then
            return {
                username = parts[1],
                high_score = tonumber(parts[2]),
                is_admin = parts[3] == "t",
                games_played = tonumber(parts[4]),
                is_privilaged = parts[5] == "t"
            }
        end
    end
    return nil
end

---Check if a user exists in the comprehensive users table
---@param username string Username to check (cannot be empty)
---@return boolean exists True if user exists, false if user not found or database error
---@return string|nil error Error message only for database/connection errors (nil when user simply doesn't exist)
---
---Example:
---  local exists, err = database.user_exists("player1")
---  if err then
---    print("Database error:", err)
---  elseif exists then
---    print("User exists!")
---  else
---    print("User not found") -- This is normal, not an error
---  end
function database.userExists(username)
    if not username or username == "" then return false, "Username cannot be empty" end

    local query = [[
SELECT EXISTS(
    SELECT 1 FROM users
    WHERE username = :username
);
]]

    local variables = { username = username }
    local ok, result = execQueryInternal(query, variables)

    if not ok then return false, result end

    return result == "t"
end

---Test the database connection to ensure it's working properly
---@return boolean success True if connection successful, false otherwise
---@return string|nil error Error message if connection failed
---
---Example:
---  local ok, err = database.test_connection()
---  if ok then
---    print("Database connection is working!")
---  else
---    print("Database connection failed:", err)
---  end
function database.testConnection()
    local ok, result = execQueryInternal("SELECT version();")
    if ok then
        return true
    else
        return false, result
    end
end

---Change a user's password with secure verification and hashing
---Verifies the old password before setting the new one
---@param username string Username whose password to change (cannot be empty)
---@param old string Current password for verification (cannot be empty)
---@param new string New password to set (minimum 6 characters, will be hashed)
---@return boolean success True if password changed successfully, false otherwise
---@return string result Query result on success (usually empty string), error message on failure
---
---Example:
---  local ok, err = database.changePass("player1", "oldpass", "newpass123")
---  if ok then
---    print("Password changed successfully!")
---  else
---    print("Failed to change password:", err)
---  end
function database.changePass(username, old, new)
    if not username or username == "" then return false, "Username cannot be empty" end
    if not old or old == "" then return false, "Old password cannot be empty" end
    if not new or new == "" then return false, "New password cannot be empty" end
    if #new < 6 then return false, "New password too short (minimum 6 characters)" end

    local authResult, authErr = database.authenticateUser(username, old)
    if not authResult then return false, "Invalid old password" .. (authErr and (": " .. authErr) or "") end

    local query = [[
UPDATE users
SET password_hash = crypt(:new_password, gen_salt('bf')),
    updated_at = CURRENT_TIMESTAMP
WHERE username = :username;
]]

    local variables = {
        username = username,
        new_password = new
    }

    return execQueryInternal(query, variables)
end

---Delete a user from the database (admin function)
---WARNING: This permanently removes the user and all associated data
---@param username string Username to delete (cannot be empty)
---@return boolean success True if user deleted successfully, false otherwise
---@return string result Query result on success (usually empty string), error message on failure
---
---Example:
---  local ok, err = database.deleteUser("olduser")
---  if ok then
---    print("User deleted successfully")
---  else
---    print("Failed to delete user:", err)
---  end
function database.deleteUser(username)
    if not username or username == "" then return false, "Username cannot be empty" end
    if username == "SRG" then return false, "Cannot delete SRG" end

    local query = "DELETE FROM users WHERE username = :username;"
    local variables = { username = username }

    return execQueryInternal(query, variables)
end

---ADMIN FUNCTIONS - Administrative functions for user and database management
---These functions are intended for admin users and include powerful database operations

---Get all users with their complete information from the comprehensive users table
---This is an admin function that returns all user data for management purposes
---@param limit number|nil Optional limit on number of users returned (default: all users)
---@return table users Array of user info tables with {username, high_score, is_admin, games_played, created_at} or empty table
---@return string|nil error Error message if query failed
---
---Example:
---  local users, err = database.getAllUsers(20)
---  if err then
---    print("Error:", err)
---  else
---    for i, user in ipairs(users) do
---      print(user.username, "Admin:", user.is_admin, "Score:", user.high_score)
---    end
---  end
function database.getAllUsers(limit)
    local query
    local variables = {}

    if limit and limit > 0 then
        query = [[
SELECT username, high_score, is_admin, games_played, created_at
FROM users
ORDER BY created_at DESC
LIMIT :limit;
]]
        variables.limit = limit
    else
        query = [[
SELECT username, high_score, is_admin, games_played, created_at
FROM users
ORDER BY created_at DESC;
]]
    end

    local ok, result = execQueryInternal(query, variables)

    local users = {}
    if not ok then return {}, result end

    if result and result ~= "" then
        for line in result:gmatch("[^\r\n]+") do
            local parts = {}
            for part in line:gmatch("[^|]+") do table.insert(parts, part) end

            if #parts >= 5 then
                table.insert(users, {
                    username = parts[1],
                    high_score = tonumber(parts[2]),
                    is_admin = parts[3] == "t",
                    games_played = tonumber(parts[4]),
                    created_at = parts[5]
                })
            end
        end
    end

    return users
end

---Reset a user's game statistics (admin function)
---WARNING: This permanently resets games_played and high_score to 0 for the specified user
---@param username string Username to reset statistics for (cannot be empty)
---@return boolean success True if stats were reset successfully, false otherwise
---@return string result Query result on success (usually empty string), error message on failure
---
---Example:
---  local ok, err = database.resetUserStats("player1")
---  if ok then
---    print("User statistics reset successfully")
---  else
---    print("Failed to reset stats:", err)
---  end
function database.resetUserStats(username)
    if not username or username == "" then return false, "Username cannot be empty" end
    if username == "SRG" then return false, "Cannot reset SRG's stats" end

    local query = [[
UPDATE users
SET high_score = 0,
    games_played = 0,
    updated_at = CURRENT_TIMESTAMP
WHERE username = :username;
]]

    local variables = { username = username }
    return execQueryInternal(query, variables)
end

---Grant admin privileges to a user (admin function)
---Sets the is_admin flag to true for the specified user
---@param username string Username to promote to admin (cannot be empty)
---@return boolean success True if user was promoted successfully, false otherwise
---@return string result Query result on success (usually empty string), error message on failure
---
---Example:
---  local ok, err = database.promote("player1")
---  if ok then
---    print("User promoted to admin successfully")
---  else
---    print("Failed to promote user:", err)
---  end
function database.promote(username)
    if not username or username == "" then return false, "Username cannot be empty" end
    if username == "SRG" then return false, "Cannot change SRG's permissions"  end

    local query = [[
UPDATE users
SET is_admin = TRUE,
    updated_at = CURRENT_TIMESTAMP
WHERE username = :username;
]]

    local variables = { username = username }
    return execQueryInternal(query, variables)
end

---Remove admin privileges from a user (admin function)
---Sets the is_admin flag to false for the specified user
---@param username string Username to demote from admin (cannot be empty)
---@return boolean success True if user was demoted successfully, false otherwise
---@return string result Query result on success (usually empty string), error message on failure
---
---Example:
---  local ok, err = database.demote("player1")
---  if ok then
---    print("User demoted from admin successfully")
---  else
---    print("Failed to demote user:", err)
---  end
function database.demote(username)
    if not username or username == "" then return false, "Username cannot be empty" end
    if username == "SRG" then return false, "Cannot change SRG's permissions" end

    local query = [[
UPDATE users
SET is_admin = FALSE,
    updated_at = CURRENT_TIMESTAMP
WHERE username = :username;
]]

    local variables = { username = username }
    return execQueryInternal(query, variables)
end

---Get overall database statistics for administrative monitoring
---Returns comprehensive statistics about users, scores, and activity
---@return table|nil stats Table containing database statistics or nil if failed
---@return string|nil error Error message if query failed
---
---Stats table contains:
--- - total_users: Total number of registered users
--- - total_admin_users: Number of users with admin privileges
--- - total_games_played: Sum of all games played by all users
--- - average_games_per_user: Average games played per user
--- - highest_score: Highest score across all users
--- - total_high_score_entries: Number of entries in high_scores table
---
---Example:
---  local stats, err = database.getDbStats()
---  if err then
---    print("Error:", err)
---  elseif stats then
---    print("Total users:", stats.total_users)
---    print("Highest score:", stats.highest_score)
---  end
function database.getDbStats()
    local query = [[
SELECT
    (SELECT COUNT(*) FROM users) as total_users,
    (SELECT COUNT(*) FROM users WHERE is_admin = TRUE) as total_admin_users,
    (SELECT COALESCE(SUM(games_played), 0) FROM users) as total_games_played,
    (SELECT CASE WHEN COUNT(*) > 0 THEN COALESCE(AVG(games_played), 0) ELSE 0 END FROM users) as average_games_per_user,
    (SELECT COALESCE(MAX(high_score), 0) FROM users) as highest_score,
    (SELECT COUNT(*) FROM high_scores) as total_high_score_entries;
]]

    local ok, result = execQueryInternal(query)

    if not ok then return nil, result end

    if result and result ~= "" then
        local parts = {}
        for part in result:gmatch("[^|]+") do table.insert(parts, part) end

        if #parts >= 6 then
            return {
                totalUsers = tonumber(parts[1]) or 0,
                totalAdminUsers = tonumber(parts[2]) or 0,
                totalGamesPlayed = tonumber(parts[3]) or 0,
                avgGamesPerUser = math.floor((tonumber(parts[4]) or 0) + 0.5), -- Round to nearest integer
                highestScore = tonumber(parts[5]) or 0,
                totalHighScoreEntries = tonumber(parts[6]) or 0
            }
        end
    end

    return nil, "Failed to parse database statistics"
end

---Reset any user's password without requiring the old password (admin function)
---WARNING: This bypasses normal password verification - admin only function
---@param username string Username whose password to reset (cannot be empty)
---@param new_password string New password to set (minimum 6 characters, will be hashed)
---@return boolean success True if password was reset successfully, false otherwise
---@return string result Query result on success (usually empty string), error message on failure
---
---Example:
---  local ok, err = database.reset_user_password("player1", "newpassword123")
---  if ok then
---    print("User password reset successfully")
---  else
---    print("Failed to reset password:", err)
---  end
function database.reset_user_password(username, new_password)
    if not username or username == "" then
        return false, "Username cannot be empty"
    end
    if username == "SRG" then
       return false, "Cannot reset SRG's password" 
    end
    if not new_password or new_password == "" then
        return false, "New password cannot be empty"
    end
    if #new_password < 6 then
        return false, "New password too short (minimum 6 characters)"
    end

    local query = [[
UPDATE users
SET password_hash = crypt(:new_password, gen_salt('bf')),
    updated_at = CURRENT_TIMESTAMP
WHERE username = :username;
]]

    local variables = {
        username = username,
        new_password = new_password
    }

    return execQueryInternal(query, variables)
end

---Clear all entries from the high_scores table (admin function)
---WARNING: This is a DESTRUCTIVE operation that permanently deletes ALL high score data
---This function should be used with extreme caution and only by administrators
---@return boolean success True if all high scores were cleared successfully, false otherwise
---@return string result Query result on success (usually empty string), error message on failure
---
---Example:
---  local ok, err = database.clear_all_high_scores()
---  if ok then
---    print("WARNING: All high scores have been permanently deleted!")
---  else
---    print("Failed to clear high scores:", err)
---  end
function database.clear_all_high_scores()
    local query = "TRUNCATE TABLE high_scores RESTART IDENTITY;"
    return execQueryInternal(query)
end

---Get most recently created users for administrative monitoring
---Returns users sorted by creation date (newest first)
---@param limit number|nil Number of recent users to return (default: 10, max: 100)
---@return table users Array of recent user info tables with {username, high_score, is_admin, games_played, created_at}
---@return string|nil error Error message if query failed
---
---Example:
---  local users, err = database.get_recent_users(5)
---  if err then
---    print("Error:", err)
---  else
---    print("Recent users:")
---    for i, user in ipairs(users) do
---      print(i, user.username, "joined:", user.created_at)
---    end
---  end
function database.getRecentUser(limit)
    limit = limit or 10
    if limit > 100 then limit = 100 end
    if limit < 1 then limit = 1 end

    local query = [[
SELECT username, high_score, is_admin, games_played, created_at
FROM users
ORDER BY created_at DESC
LIMIT :limit;
]]

    local variables = { limit = limit }
    local ok, result = execQueryInternal(query, variables)

    local users = {}
    if not ok then
        return {}, result -- result contains error message
    end

    if result and result ~= "" then
        for line in result:gmatch("[^\r\n]+") do
            local parts = {}
            for part in line:gmatch("[^|]+") do
                table.insert(parts, part)
            end

            if #parts >= 5 then
                table.insert(users, {
                    username = parts[1],
                    high_score = tonumber(parts[2]),
                    is_admin = parts[3] == "t",
                    games_played = tonumber(parts[4]),
                    created_at = parts[5]
                })
            end
        end
    end

    return users
end

return database
