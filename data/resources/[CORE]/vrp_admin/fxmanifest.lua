


fx_version 'adamant'
game 'gta5'

author 'Projeto Z'

client_scripts {
	'@vrp/lib/utils.lua',
	'config/config.lua',
	'hansolo/*.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'@oxmysql/lib/MySQL.lua',
	'config/config.lua',
	'skywalker.lua'
}

dependencies {
    'oxmysql'
}