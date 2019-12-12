local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()
local usernames = require("usernames")
local carImage
local carRotation = 360

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
            if system.getInfo( "androidApiLevel" ) and system.getInfo( "androidApiLevel" ) < 19 then
    native.setProperty( "androidSystemUiVisibility", "lowProfile" )
else
    native.setProperty( "androidSystemUiVisibility", "immersiveSticky" ) 
end
        
        --Car selection and display
        car = display.newGroup()
        sceneGroup:insert(car)
        local userCar = getCar(getCurrentUser())
        local currentSelection = 0
        
        local carNames = {"redCar", "orangeCar", "yellowCar", "greenCar", "blueCar", "purpleCar"}    
        for i, x in ipairs(carNames) do
            if x == userCar then
                currentSelection = i
            end
        end
        
        carImage = display.newImageRect(car, "Content/Cars/" .. carNames[currentSelection] .. ".png", display.contentWidth/5, display.contentHeight/5)
         
        carImage.x, carImage.y = display.contentWidth/2, display.contentHeight/2.2
        
        --showing the next car
        function nextCar()
            if currentSelection + 1 > table.getn(carNames) then
                currentSelection = 0
            end
            currentSelection = currentSelection + 1
            carImage:removeSelf()
            
            carImage = display.newImageRect(car, "Content/Cars/" .. carNames[currentSelection] .. ".png", display.contentWidth/5, display.contentHeight/5)
            carImage.x, carImage.y = display.contentWidth/2, display.contentHeight/2.2
            setCar(carNames[currentSelection])
        end
        
        local nextCarButton = widget.newButton(
            {
                label = "Next Car",
                labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
                fontSize = 20,
                width = display.contentWidth/2.5,
                height = 40,
                x = display.contentWidth/1.335,
                y = display.contentHeight/1.55,
                shape = "roundedRect",
                fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
                onRelease = nextCar
            }
        )
        sceneGroup:insert(nextCarButton)
        
        --showing the previous car
        function previousCar()
            if currentSelection - 1 < 1 then
                currentSelection = table.getn(carNames)
            end
            currentSelection = currentSelection - 1
            carImage:removeSelf()
            
            carImage = display.newImageRect(car, "Content/Cars/" .. carNames[currentSelection] .. ".png", display.contentWidth/5, display.contentHeight/5)
            carImage.x, carImage.y = display.contentWidth/2, display.contentHeight/2.2
            setCar(carNames[currentSelection])
        end
        
        local previousCarButton = widget.newButton(
            {
                label = "Previous Car",
                labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
                fontSize = 20,
                width = display.contentWidth/2.5,
                height = 40,
                x = display.contentWidth/4,
                y = display.contentHeight/1.55,
                shape = "roundedRect",
                fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
                onRelease = previousCar
            }
        )
        sceneGroup:insert(previousCarButton)
        
        --
        
        
        --Log out button
        function logout()
            setCurrentUser("")
            composer.gotoScene("logInScene")            
        end
        local logoutButton = widget.newButton(
            {
                label = "Log Out",
                labelColor = {default={1, 0, 0}, over={1, 0, 0}},
                fontSize = 20,
                width = display.contentWidth - 30,
                height = 40,
                x = display.contentWidth/2,
                y = display.contentHeight/1.35,
                shape = "roundedRect",
                fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
                onRelease = logout
            }
        )
        sceneGroup:insert(logoutButton)
        
        
        --Back Button
        function goBack()
            composer.gotoScene("loggedInScreen")
        end

        
        local backButton = widget.newButton( 
            {
                label = "Back",
                labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
                fontSize = 20,
                width = display.contentWidth - 30,
                height = 40,
                x = display.contentWidth/2,
                y = display.contentHeight/1.2,
                shape = "roundedRect",
                fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
                onRelease = goBack
            }
        )
        sceneGroup:insert(backButton)
    -- Called when the scene is still off screen (but is about to come on screen).

        function turnCar()
            carImage.rotation = carRotation
            carRotation = carRotation - 360/(60*12)
            if carRotation < 0 then
                carRotation = 360
            end
        end
        
  elseif ( phase == "did" ) then
        Runtime:addEventListener("enterFrame", turnCar) 
  end
end

--------------------------------------------------------------------------------
-- "scene:hide()"
--------------------------------------------------------------------------------
function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
        carImage:removeSelf()
        Runtime:removeEventListener("enterFrame", turnCar)
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



