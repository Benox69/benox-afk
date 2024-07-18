fx_version 'cerulean'

game 'gta5'
description 'Simple anti-afk script'
author 'benox'
lua54 'yes'

server_scripts {
	'config.lua',
	'server.lua',
}

client_scripts {
	'config.lua',
	'client.lua',
}

ui_page {
	'/ui/index.html',
}

files {
	'/ui/index.html',
	'/ui/style.css',
	'/ui/script.js',
}
