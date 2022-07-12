


fx_version 'cerulean'
game 'gta5'

author ''
description ''
version '1.0.0'

server_scripts {
    '@vrp/lib/utils.lua',
    'server/server.lua'
}

client_scripts {
    '@vrp/lib/utils.lua',
    'client/*.lua'
}

-- ui_page 'html/index.html'

-- files {
--	'html/*.html',
--	'html/*.js',
--	'html/*.png',
--	'html/*.css',
-- }

lua54 'yes'
