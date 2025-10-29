require("Useful Lua Tools")

print("=== SHA256 Implementation Test ===\n")

-- Test vectors from FIPS 180-2
local tests = {
    {
        input = "",
        expected = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
        description = "Empty string"
    },
    {
        input = "abc",
        expected = "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
        description = "String 'abc'"
    },
    {
        input = "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq",
        expected = "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1",
        description = "String 'abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq'"
    },
    {
        input = "The quick brown fox jumps over the lazy dog",
        expected = "d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592",
        description = "String 'The quick brown fox jumps over the lazy dog'"
    },
    {
        input = "a",
        expected = "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb",
        description = "Single character 'a'"
    }
}

local passed = 0
local failed = 0

for i, test in ipairs(tests) do
    print("Test " .. i .. ": " .. test.description)
    print("  Input: '" .. test.input .. "'")
    
    local result = cryptography.sha256(test.input)
    
    print("  Expected: " .. test.expected)
    print("  Got:      " .. result)
    
    if result == test.expected then
        print("  ✓ PASS\n")
        passed = passed + 1
    else
        print("  ✗ FAIL\n")
        failed = failed + 1
    end
end

print("=== Results ===")
print("Passed: " .. passed .. "/" .. #tests)
print("Failed: " .. failed .. "/" .. #tests)

if failed == 0 then
    print("\n🎉 All tests passed! SHA256 implementation is correct.")
else
    print("\n❌ Some tests failed. There may be bugs in the implementation.")
end
