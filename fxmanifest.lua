
fx_version 'cerulean'
game 'gta5'

author 'Roderic#0416'

description 'Roda Is Here Hud'

client_scripts {
    'Client/*.lua',
}

server_scripts {
    'Server/*.lua',
}

shared_scripts {
    'Config.lua'
}

ui_page {
    'html/index.html',
}

files {
	'html/index.html',
	'html/app.js', 
    'html/style.css',
    'html/dist/**'
}

exports {
    'NotificationIsHere'
}