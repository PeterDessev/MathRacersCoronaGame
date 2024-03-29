local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()
local usernames = require("usernames")

--------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
--------------------------------------------------------------------------------
-- local forward references should go here
--------------------------------------------------------------------------------
        --User Inputs
        local logInUsernameInput = native.newTextField(display.actualContentWidth/2, (2*display.actualContentHeight)/6.7, display.actualContentWidth-100, 35)
        logInUsernameInput.placeholder = "Username"
        logInUsernameInput.font = native.newFont(Arial)
        


        local logInPasswordInput = native.newTextField(display.actualContentWidth/2, (3*display.actualContentHeight)/7.5, display.actualContentWidth-100, 35)
        logInPasswordInput.placeholder = "Password"
        logInPasswordInput.font = native.newFont(Arial)
        logInPasswordInput.isSecure = true
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
    
            local logInText = display.newText("Log-In", display.actualContentWidth/2, display.actualContentHeight/6, Arial, 40)
        logInText:setFillColor(0, 0, 0)
        sceneGroup:insert(logInText)

        local errorOptions = {
            text = "",
            x = display.actualContentWidth/2,
            y = 4*display.actualContentHeight/6 + display.actualContentHeight/13,
            font = Arial,
            fontSize = 12,

        }

        local errorText = display.newText(errorOptions)
        errorText:setFillColor(1, 0, 0)
        sceneGroup:insert(errorText)


    
    
    
        --Check LogIn Info
        function logInCheck(event)
            --
            if event.phase == "ended" then
                if(logInUsernameInput.text == nil or logInUsernameInput.text == "") then
                    errorText.text = "Please enter a username"
                elseif(getUser(logInUsernameInput.text) == nil or getUser(logInUsernameInput.text) ~= logInPasswordInput.text) then
                    errorText.text = "Username or password incorrect, please try again"
                else
                    errorText.text = ""
                    setCurrentUser(logInUsernameInput.text)
                    logInUsernameInput.isVisible = false
                    logInPasswordInput.isVisible = false
                 
                        composer.gotoScene("loggedInScreen")
                
                end
            end
            --]]
        end


 
        local logInButton = widget.newButton(
            {
                label = "Log-In",
                labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
                fontSize = 20,
                width = 80,
                height = 40,
                x = display.actualContentWidth/2 - display.actualContentWidth/4,
                y = 3*display.actualContentHeight/4 - display.actualContentHeight/4.5,
                shape = "roundedRect",
                fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
                onEvent = logInCheck,
            }
        )
        sceneGroup:insert(logInButton)




        --go create account
        function goToCreateAccount()
            errorText.text = ""
            logInUsernameInput.isVisible = false
            logInPasswordInput.isVisible = false
            composer.gotoScene("createAccountScreen")
        end
    
        

        local createAccountButton = widget.newButton(
            {
                label = "Create Account",
                labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
                fontSize = 20,
                width = 160,
                height = 40,
                x = display.actualContentWidth/2 + display.actualContentWidth/5,
                y = 3*display.actualContentHeight/4 - display.actualContentHeight/4.5,
                shape = "roundedRect",
                fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
                onRelease = goToCreateAccount
            }
        )
        sceneGroup:insert(createAccountButton)

        
        --go to leaderboard        
       local function goToLeaderboard()
            errorText.text = ""
            logInUsernameInput.isVisible = false
            logInPasswordInput.isVisible = false
            setLeaderboardOrigin("logInScene")
            composer.gotoScene("leaderboardScene")
        end
        
        local leaderBoardButton = widget.newButton(
            {
                label = "Leaderboard",
                labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
                fontSize = 20,
                width = 135,
                height = 40,
                x = display.actualContentWidth/2,
                y = 3*display.actualContentHeight/4 - display.actualContentHeight/10,
                shape = "roundedRect",
                fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
                onRelease = goToLeaderboard
            }
        )
        sceneGroup:insert(leaderBoardButton)
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
        logInUsernameInput.isVisible = true
        logInPasswordInput.isVisible = true
        logInUsernameInput.text = ""
        logInPasswordInput.text = ""
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
