fx_version 'cerulean'
game 'gta5'

name "benzo-policenotify"
description "Notify Police "
author "Benzo"
version "1.0.0"

shared_scripts {
	'@ox_lib/init.lua', -- Uncomment this if using ox_lib
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}
