{ pkgs }: {
  deps = [
    pkgs.lua5_4
    pkgs.luajitPackages.luarocks
    pkgs.lua-language-server
  ];
}