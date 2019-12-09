local composer = require( "composer" )
local sqlite3 = require( "sqlite3" )
local usernames = require("usernames")

display.setDefault("background", 1, 1, 1)

if system.getInfo( "androidApiLevel" ) and system.getInfo( "androidApiLevel" ) < 19 then
    native.setProperty( "androidSystemUiVisibility", "lowProfile" )
else
    native.setProperty( "androidSystemUiVisibility", "immersiveSticky" ) 
end

initiateTable()
 
composer.gotoScene("logInScene")
--composer.gotoScene("loggedInScreen")

