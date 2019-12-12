local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()
local usernames = require("usernames")
local loggedInTimeText
local levelNameText
local track
local loggedInWelcomeText
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
    


end
--------------------------------------------------------------------------------
-- "scene:show()"
--------------------------------------------------------------------------------
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    
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
            x = display.contentWidth/2,
            y = display.contentHeight/1.025,
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
            x = display.contentWidth - display.contentWidth/50,
            y = 0,
            fillColor = {default={1, 1, 1}, over={1, 1, 1}},
            onRelease = gotoSettings
        })
    sceneGroup:insert(gotoSettingsButton)
    gotoSettingsButton.anchorX, gotoSettingsButton.anchorY, gotoSettingsButton.textOnly = 1, 0, true
    
    
    if ( phase == "will" ) then
    local timeMessage = "Best Time: " .. getTime(getCurrentUser(), "Level 1")
    if not string.find(timeMessage, "No") then
        timeMessage = timeMessage .. " seconds."
    end
        
    local welcomeMessage = "Welcome, " .. getCurrentUser()
    print("current user: ", getCurrentUser())
    print("Level 1 time: ", getTime(getCurrentUser(), "Level 1") .. " seconds")
    
    loggedInWelcomeText = display.newText(welcomeMessage, display.contentWidth/50, display.contentWidth/50, Arial, 30)
    loggedInWelcomeText:setFillColor(0, 0, 0)
    sceneGroup:insert(loggedInWelcomeText)
    loggedInWelcomeText.anchorX, loggedInWelcomeText.anchorY = 0, 0    
        
    loggedInTimeText = display.newText("", display.contentWidth/50, display.contentWidth/50 + 40, Arial, 20)
    loggedInTimeText:setFillColor(0, 0, 0)
    sceneGroup:insert(loggedInTimeText)
    
    loggedInTimeText.text = timeMessage
    loggedInTimeText.anchorX, loggedInTimeText.anchorY = 0, 0
        
        
    
    levelNameText = display.newText("Level 1", display.contentWidth/2, display.contentHeight/6, Arial, 20)
    levelNameText:setFillColor(0,0,0)
    sceneGroup:insert(levelNameText)
    
    map = display.newGroup()
    sceneGroup:insert(map)
    
    local levelCounter = 1
    local selectedLevel = "Level1"  
    local maxLevels = 2
    
    local mapy = 406.34921264648/1.4
    local mapx = 285.05096435547/1.4
    track = display.newImageRect(map, "Content/Levels/Level1.png", mapx, mapy)
    track.x, track.y = display.contentWidth/2, display.contentHeight/2
    
    function downLevel()
        if levelCounter > 1 then
            levelCounter = levelCounter - 1
            selectedLevel= "Level " .. tostring(levelCounter)
            levelNameText.text = selectedLevel
                
            print(selectedLevel)
            local timeMessage = "Best Time: " .. getTime(getCurrentUser(), selectedLevel)
            if not string.find(timeMessage, "No") then
                timeMessage = timeMessage .. " seconds."
            end
            loggedInTimeText.text = timeMessage
        end
        track:removeSelf()
        
        track = display.newImageRect(map, "Content/Levels/Level" ..  tostring(levelCounter) .. ".png", mapx, mapy)
        track.x, track.y = display.contentWidth/2, display.contentHeight/2
    end
    
    function upLevel()
        if levelCounter < maxLevels then
            levelCounter = levelCounter + 1
            selectedLevel = "Level " .. tostring(levelCounter)
            levelNameText.text = selectedLevel
                
            print(selectedLevel)
            local timeMessage = "Best Time: " .. getTime(getCurrentUser(), selectedLevel)
            if not string.find(timeMessage, "No") then
                timeMessage = timeMessage .. " seconds."
            end
            loggedInTimeText.text = timeMessage
        end
        track:removeSelf()
        
        track = display.newImageRect(map, "Content/Levels/Level" ..  tostring(levelCounter) .. ".png", mapx, mapy)
        track.x, track.y = display.contentWidth/2, display.contentHeight/2
    end
    
    local nextLevel = widget.newButton({
            label = "Next",
            labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
            fontSize = 20,
            width = 60,
            height = 40,
            x = 3*display.contentWidth/4 + 20,
            y = display.contentHeight/1.15,
            shape = "roundedRect",
            fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
            onRelease = upLevel
        })
    sceneGroup:insert(nextLevel)
    
    local previousLevel = widget.newButton({
            label = "Previous",
            labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
            fontSize = 20,
            width = 100,
            height = 40,
            x = display.contentWidth/4,
            y = display.contentHeight/1.15,
            shape = "roundedRect",
            fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
            onRelease = downLevel
        })
    sceneGroup:insert(previousLevel)
    
    
--[[    function checkLevel()
        local max = 2   --Change me to add more levels 
        if levelCounter > max then
            levelCounter = max
        elseif levelCounter < 1 then
            levelCounter = 1 
        else

        end
    end--]]    
    
    function playGame()
        print("asdfasdf")
        SelectedLevel = "level" .. levelCounter
        composer.gotoScene("GameLevels." .. SelectedLevel)
    end
    
    local playGameButton = widget.newButton({
            label = "Play",
            labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
            fontSize = 20,
            width = 60,
            height = 40,
            x = display.contentWidth/2 + 20,
            y = display.contentHeight/1.15,
            shape = "roundedRect",
            fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
            onRelease = playGame
        })
    sceneGroup:insert(playGameButton)
    
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
    loggedInTimeText:removeSelf()
    levelNameText:removeSelf()
    track:removeSelf()
    loggedInWelcomeText:removeSelf()
    sceneGroup:removeSelf()
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
