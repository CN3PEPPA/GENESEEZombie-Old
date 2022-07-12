


fx_version 'adamant'
game 'gta5'
ui_page 'html/form.html'
files {
	'html/*',
	'html/**/*'
}
client_scripts{
	'@vrp/lib/utils.lua',
    'config.lua',
    'client/client.lua',
}
server_scripts{
	'@vrp/lib/utils.lua',
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/server.lua'
}