


fx_version 'adamant'

game 'gta5'

author 'okok#3488'
description 'GENESEEChat'

ui_page 'web/ui.html'

files {'web/*.*'}

shared_script 'config.lua'

client_scripts {'@vrp/lib/utils.lua', 'client.lua'}

server_scripts {'@vrp/lib/utils.lua', 'server.lua', 'commands.lua'}

lua54 'yes'