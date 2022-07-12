
fx_version 'adamant'

game 'gta5'

author 'Lorenzo#0483'
description 'Rad zone QBCore Version'

version '1.0'

lua54 'yes'

client_scripts {
    '@vrp/lib/utils.lua',
    'configs/*.lua',
    'client/*.lua',
}

escrow_ignore {
    'client/radzone.lua',
    'configs/radzone.lua'
}

dependency '/assetpacks'