fx_version 'cerulean'

game 'gta5'
description 'Simple anti-afk script'
author 'benox'
lua54 'yes'
version '1.10.5'


server_scripts {
	'config.lua',
	'server.lua',
}

client_scripts {
	'config.lua',
	'client.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
}
ui_page {
	'/ui/index.html',
}

files {
	'/ui/index.html',
	'/ui/style.css',
	'/ui/script.js',
}


dependency 'es_extended'