


fx_version 'adamant'
game 'gta5'
ui_page 'html/form.html'
files {
	'html/form.html',
	'html/css.css',
	'html/img/*.png',
	'html/script.js',
	'html/jquery-3.4.1.min.js',
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
	'server/server.lua',
}