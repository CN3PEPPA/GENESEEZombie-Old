
fx_version 'bodacious'
game 'gta5'

author "Mapree Dev Team"

ui_page 'nui/ui.html'

files {
    'nui/*',
    'nui/*/*',
}

client_scripts {
	'@vrp/lib/utils.lua',
	'client.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua'
}

