fx_version 'cerulean'
game 'gta5'

author 'Cramtpé'
description 'Khalifouille'
version '1.0.0'

server_scripts {
    '@es_extended/locale.lua',
    'server.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'client.lua'
}

dependencies {
    'es_extended'
}

files {
    'image.png',
    'ui.html'
}

ui_page 'ui.html'