


fx_version 'bodacious'
game 'gta5'

version '1.0.0'

client_scripts {
	'@vrp/lib/utils.lua',
	'client.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua'
}

files {
  'html/**/**/*',
  'html/**/*',
  'html/*',
}

ui_page 'html/index.html'