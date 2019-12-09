local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")
local usernames = require("usernames")
local places = {}
local names = {}
local times = {}
--------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
--------------------------------------------------------------------------------
-- local forward references should go here
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- "scene:create()"
--------------------------------------------------------------------------------
function scene:create( event )
    local sceneGroup = self.view
    if system.getInfo( "androidApiLevel" ) and system.getInfo( "androidApiLevel" ) < 19 then
    native.setProperty( "androidSystemUiVisibility", "lowProfile" )
else
    native.setProperty( "androidSystemUiVisibility", "immersiveSticky" ) 
end
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end

--------------------------------------------------------------------------------
-- "scene:show()"
--------------------------------------------------------------------------------
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
                        
        local leaderboardTextOptions = {
                text = "Leader Board",
                x = display.actualContentWidth/2,
                y = display.actualContentHeight/20,
                font = Arial,
                fontSize = 40,
            }
        
        local LeaderboardText = display.newText(leaderboardTextOptions)
        LeaderboardText:setFillColor(0, 0, 0)
        sceneGroup:insert(LeaderboardText)
        
        local leaderboardTextOptions = {
                text = "Level 1",
                x = display.actualContentWidth/2,
                y = display.actualContentHeight/8,
                font = Arial,
                fontSize = 25,
            }
        
        local LeaderboardText = display.newText(leaderboardTextOptions)
        LeaderboardText:setFillColor(0, 0, 0)
        sceneGroup:insert(LeaderboardText)
         
        
        function goBack()
            composer.gotoScene(getLeaderboardOrigin())
        end


        local backButton = widget.newButton(
            {
                label = "Back",
                labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
                fontSize = 20,
                width = 70,
                height = 40,
                x = display.actualContentWidth/2,
                y = display.actualContentHeight/1.2,
                shape = "roundedRect",
                fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
                onRelease = goBack
            }
        )
        sceneGroup:insert(backButton)
        
        
        
       
        local function leaderboardEntry(name, time)
            local self = {}
            
            function self.printSelf()

            end
            
            return self    
        end
            
            
        local leaderboardTimesOptions = {
                text = "",
                x = display.actualContentWidth/2,
                y = display.actualContentHeight/2,
                font = Arial,
                fontSize = 40,
        }
        
        --local leaderboardTimes = display.newText(leaderboardTimesOptions)
        --leaderboardTimes:setFillColor(0, 0, 0) 
        
        local unsortedTimes = {}
        local allTimes = getAllTimes()
        if allTimes == "no Scores" then
            print("no Scores found")
        else
            for i, x in ipairs(allTimes) do
                unsortedTimes[i] = {x.Name, x.Time}
            end
        end
    
        table.sort(unsortedTimes, function (a, b) return a[2] < b[2] end)
        
-----------------------------        
--Setting up the leaderboard
-----------------------------
        local leaderboardFontSize = 30
        local leaderboardRowSpacer = 0.7
        local placeTextOptions
        local nameTextOptions
        local timeTextOptions
        local placeTexts = {}
        local placeNumber = 1
        
        
        for i, x in ipairs(unsortedTimes) do
            if x[2] <= 100 then 
                print(x[2], "adding " .. x[1] .. " to place " .. placeNumber)
                placeTexts[placeNumber] = x
                placeNumber = placeNumber + 1
            else 
                print(x[2], "removing " .. x[1] .. " from place " .. placeNumber)
            end
        end   
        
        for i, x in ipairs(placeTexts) do 
            
            --print("Place: " .. i, "Name: " .. x[1], "Time: " .. x[2])
            
            --Placeing Text for the Place
            placeTextOptions = {
                text = tostring(i) .. ":", 
                x = 0.5*(display.actualContentWidth/10), 
                y = (leaderboardRowSpacer*i*display.actualContentHeight)/10+display.actualContentHeight/8, 
                font = Arial, 
                fontSize = leaderboardFontSize
            }
            places[i] = display.newText(placeTextOptions)
            places[i].anchorX = 0
            places[i]:setFillColor(0, 0, 0)      
            sceneGroup:insert(places[i])
            
            --Placing Text for the Name
            nameTextOptions = {
                text = tostring(x[1]), 
                x = 1.8*(display.actualContentWidth/10), 
                y = (leaderboardRowSpacer*i*display.actualContentHeight)/10+display.actualContentHeight/8, 
                font = Arial, 
                fontSize = leaderboardFontSize
            }
            names[i] = display.newText(nameTextOptions)
            names[i].anchorX = 0
            names[i]:setFillColor(0, 0, 0)
            sceneGroup:insert(names[i])            
            
            --Placing Text for the Time
            timeTextOptions = {
                text = tostring(x[2]), 
                x = 8*(display.actualContentWidth/9.5), 
                y = (leaderboardRowSpacer*i*display.actualContentHeight)/10+display.actualContentHeight/8, 
                font = Arial, 
                fontSize = leaderboardFontSize
            }
            times[i] = display.newText(timeTextOptions)
            names[i].anchorX = 0
            times[i]:setFillColor(0, 0, 0)
            sceneGroup:insert(times[i])
        end
        
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
    for i in ipairs(times) do
        times[i].text = ""
        places[i].text = ""
        names[i].text = ""
    end
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

