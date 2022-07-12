

fx_version 'cerulean'
game 'gta5'
author 'Projeto Z Team'
server_script {
	"@vrp/lib/utils.lua",
	"server.lua"	
}
client_script {
	"@vrp/lib/utils.lua",
	"client.lua"	
}
ui_page 'html/ui.html'
files {
	'html/*',
	'html/font/*',
	'html/images/*'
}
client_script "scripting_lua.lua"