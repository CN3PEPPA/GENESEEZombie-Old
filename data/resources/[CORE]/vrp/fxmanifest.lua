

fx_version 'adamant'
game 'gta5'

ui_page 'gui/index.html'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'lib/utils.lua',
	'lib/lib.lua',
	'base.lua',
	'wac.lua',
	'queue.lua',
	'genesee/*',
	'modules/*'
}

client_scripts {
	'lib/utils.lua',
	'genesee/*',
	'client/*',
}

files {
	'lib/Tunnel.lua',
	'lib/Proxy.lua',
	'lib/Luaseq.lua',
	'lib/Tools.lua',
	'gui/*',
}

server_export 'AddPriority'
server_export 'RemovePriority'