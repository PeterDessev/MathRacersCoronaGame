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
        local CAUsernameInput = native.newTextField(display.actualContentWidth/2, (2*display.actualContentHeight)/6.7, display.actualContentWidth-100, 35)
        CAUsernameInput.placeholder = "Username"
        CAUsernameInput.font = native.newFont(Arial)


        local CAPasswordInput = native.newTextField(display.actualContentWidth/2, (3*display.actualContentHeight)/7.5, display.actualContentWidth-100, 35)
        CAPasswordInput.placeholder = "Password"
        CAPasswordInput.font = native.newFont(Arial)
        CAPasswordInput.isSecure = true

        
        local confirmPasswordInput = native.newTextField(display.actualContentWidth/2, (3*display.actualContentHeight)/6, display.actualContentWidth-100, 35)
        confirmPasswordInput.placeholder = "Confirm Password"
        confirmPasswordInput.font = native.newFont(Arial)
        confirmPasswordInput.isSecure = true
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
    
            local createAccountTextOptions = {
            text = "Create An Account",
            x = display.actualContentWidth/2,
            y = display.actualContentHeight/8.5,
            font = Arial,
            fontSize = 40,
            width = display.actualContentWidth/2,
            align = "center",
        }
        local CreateAccountText1 = display.newText(createAccountTextOptions)
        CreateAccountText1:setFillColor(0, 0, 0)
        sceneGroup:insert(CreateAccountText1)

        --[[
        local CreateAccountText2 = display.newText("Account", display.actualContentWidth/2, display.actualContentHeight/6, Arial, 40)
        CreateAccountText2:setFillColor(0, 0, 0)
        sceneGroup:insert(CreateAccountText2)--]]
        
        local errorOptions = {
            text = "",
            x = display.actualContentWidth/2,
            y = 5*display.actualContentHeight/6 - display.actualContentHeight/9,
            font = Arial,
            fontSize = 12,

        }

        local errorText = display.newText(errorOptions)
        errorText:setFillColor(1, 0, 0)
        sceneGroup:insert(errorText)

        --Check LogIn Info
        function createAccountCheck(event)
            if event.phase == "ended" then
                if (CAUsernameInput.text == nil or CAUsernameInput.text == "") then
                    errorText.text = "Please enter a username"
                elseif (getUser(CAUsernameInput.text) ~= nil) then
                    errorText.text = "Username taken, try another one"
                elseif (CAPasswordInput.text == "" or confirmPasswordInput.text == "")then
                    errorText.text = "Please enter both passwords"
                elseif (CAPasswordInput.text ~= confirmPasswordInput.text) then
                    errorText.text = "Passwords don't match, try again"           
                else
                    errorText.text = ""
                    
                    addUser(CAUsernameInput.text, CAPasswordInput.text)
                    setCurrentUser(CAUsernameInput.text)
                    
                    CAUsernameInput.isVisible = false
                    CAPasswordInput.isVisible = false
                    confirmPasswordInput.isVisible = false
                    
                    createUser(getCurrentUser())
                    local screenTransitionOptions = {
                        params = {currentUser = CAUsernameInput.text},
                    }
                    composer.gotoScene("GameLevels.tutorial", screenTransitionOptions)

                end
            end
        end



        local createAccountButton = widget.newButton(
            {

                label = "Create Account",
                labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
                fontSize = 20,
                width = 160,
                height = 40, 
                x = display.actualContentWidth/2 + display.actualContentWidth/5,
                y = 3*display.actualContentHeight/4 - display.actualContentHeight/8,
                shape = "roundedRect",
                fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
                onEvent = createAccountCheck,
            }
        )
        sceneGroup:insert(createAccountButton)




        --go create account

        function goToCreateAccount()
            errorText.text = ""
            CAUsernameInput.isVisible = false
            CAPasswordInput.isVisible = false
            confirmPasswordInput.isVisible = false
            composer.gotoScene("logInScene")
        end


        local backButton = widget.newButton(
            {
                label = "Back",
                labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
                fontSize = 20,
                width = 70,
                height = 40,
                x = display.actualContentWidth/2 - display.actualContentWidth/4,
                y = 3*display.actualContentHeight/4 - display.actualContentHeight/8,
                shape = "roundedRect",
                fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
                onRelease = goToCreateAccount
            }
        )
        sceneGroup:insert(backButton)
        
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

        CAUsernameInput.isVisible = true
        CAPasswordInput.isVisible = true
        confirmPasswordInput.isVisible = true
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

