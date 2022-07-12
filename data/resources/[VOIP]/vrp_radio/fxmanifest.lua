
fx_version "cerulean"
game "gta5"
ui_page "dist/index.html"
server_scripts {"@vrp/lib/utils.lua", "sv.lua"}
client_scripts {"@vrp/lib/utils.lua", "cl.lua"}
files {"dist/**/*"}

dependencies {"vrp", "pma-voice"}
