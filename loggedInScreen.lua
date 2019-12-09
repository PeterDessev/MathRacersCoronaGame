local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()
local usernames = require("usernames")
local loggedInTimeText
-------------------------------------------------------------------------------- 
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
--------------------------------------------------------------------------------
-- local forward references should go here
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- "scene:create()"
--------------------------------------------------------------------------------
local scene = composer.newScene()

function scene:create( event )
    local sceneGroup = self.view
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    if system.getInfo( "androidApiLevel" ) and system.getInfo( "androidApiLevel" ) < 19 then
        native.setProperty( "androidSystemUiVisibility", "lowProfile" ) 
    else
        native.setProperty( "androidSystemUiVisibility", "immersiveSticky" ) 
    end 
    
    local welcomeMessage = "Welcome, " .. getCurrentUser()
    print("current user: ", getCurrentUser())
    print("Level 1 time: ", getTime(getCurrentUser()) .. " seconds")
    
    local loggedInWelcomeText = display.newText(welcomeMessage, display.actualContentWidth/50, display.actualContentWidth/50, Arial, 30)
    loggedInWelcomeText:setFillColor(0, 0, 0)
    sceneGroup:insert(loggedInWelcomeText)
    
    loggedInWelcomeText.anchorX, loggedInWelcomeText.anchorY = 0, 0

    
    function playGame()
        composer.gotoScene("GameLevels.level")
    end
    
    local playGameButton = widget.newButton({
            label = "Play",
            labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
            fontSize = 20,
            width = 60,
            height = 40,
            x = display.actualContentWidth/2,
            y = display.actualContentHeight/1.35,
            shape = "roundedRect",
            fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
            onRelease = playGame
        })
    sceneGroup:insert(playGameButton)
    
    function gotoLeaderboard()
        setLeaderboardOrigin("loggedInScreen")
        composer.gotoScene("leaderboardScene")
    end

    local gotoLeaderboardButton = widget.newButton({
            label = "Leaderboard",
            labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
            fontSize = 20,
            width = 135,
            height = 40,
            x = display.actualContentWidth/2,
            y = display.actualContentHeight/1.2,
            shape = "roundedRect",
            fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
            onRelease = gotoLeaderboard
        })
    sceneGroup:insert(gotoLeaderboardButton)
    
    function gotoSettings()
        composer.gotoScene("settingsScreen")
    end
    
    local gotoSettingsButton = widget.newButton({
            label = "☰",
            labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
            fontSize = 40,
            width = 40, 
            height = 40,
            x = display.actualContentWidth - display.actualContentWidth/50,
            y = 0,
            onRelease = gotoSettings
        })
    sceneGroup:insert(gotoSettingsButton)
    gotoSettingsButton.anchorX, gotoSettingsButton.anchorY, gotoSettingsButton.textOnly = 1, 0, true

end
--------------------------------------------------------------------------------
-- "scene:show()"
--------------------------------------------------------------------------------
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    local timeMessage = "Best Time: " .. getTime(getCurrentUser())
    if not string.find(timeMessage, "No") then
        timeMessage = timeMessage .. " seconds."
    end
        
    loggedInTimeText = display.newText("", display.actualContentWidth/50, display.actualContentWidth/50 + 40, Arial, 20)
    loggedInTimeText:setFillColor(0, 0, 0)
    sceneGroup:insert(loggedInTimeText)
    
    loggedInTimeText.text = timeMessage
    loggedInTimeText.anchorX, loggedInTimeText.anchorY = 0, 0
    -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    end
end

--------------------------------------------------------------------------------
-- "scene:hide()"
--------------------------------------------------------------------------------
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    loggedInTimeText.text = ""
    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
    -- Called immediately after scene goes off screen.
    end
end

--------------------------------------------------------------------------------
-- "scene:destroy()"
--------------------------------------------------------------------------------
function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

--------------------------------------------------------------------------------
-- Listener setup
--------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
--------------------------------------------------------------------------------

return scene
