local composer = require( "composer" )
local scene = composer.newScene()
local track, car, background
local widget = require("widget")
local usernames = require("usernames")
local freezeTime = false
local t = {}
-- All code outside of the listener functions will only be executed ONCE 
-- unless "composer.removeScene()" is called.
-- local forward references should go here



--------------------------------------------------------------------------------
-- "scene:create()"
--------------------------------------------------------------------------------
function scene:create( event )
    

end    


--------------------------------------------------------------------------------
-- "scene:show()"
--------------------------------------------------------------------------------
function scene:show( event )
    freezeTime = false
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
  local sceneGroup = self.view
   if system.getInfo( "androidApiLevel" ) and system.getInfo( "androidApiLevel" ) < 19 then
    native.setProperty( "androidSystemUiVisibility", "lowProfile" )
else
    native.setProperty( "androidSystemUiVisibility", "immersiveSticky" ) 
end 
    
    function round(num, numDecimalPlaces)
        local mult = 10^(numDecimalPlaces or 0)
        return math.floor(num * mult + 0.5) / mult
    end
    
    
  local tutorialTextOptions = {
            text = "Time: 0.00",
            font = Arial,
            fontSize = 30,
            x = display.actualContentWidth/2,
            y = 0,
        }
        

    tutorialText = display.newText(tutorialTextOptions)
    sceneGroup:insert(tutorialText)
    tutorialText:setFillColor(0,0,0)
    
    
    local questionTextOptions = {
            text = "",
            font = Arial,
            fontSize = 25,
            x = display.actualContentWidth/2,
            y = display.actualContentHeight/20,
        }
    
    questionText = display.newText(questionTextOptions)
    sceneGroup:insert(questionText)
    questionText:setFillColor(0,0,0)
    
    
------------------------
--   Answer Buttons   --
------------------------
    local chosenButton = 0

    
    --Answer button 1
    function checkAnswer1()
        if chosenButton == 1 then
            speedUpCar()
            setQuestion()
        else
            slowDownCar()
            setQuestion()
        end
    end
    
    local answerButton1 = widget.newButton(
        {
            label = "",
            x = (display.actualContentWidth/8), 
            
            --universal properties of answer buttons
            labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
            font = Arial, 
            fontSize = 20,
            width = (display.actualContentWidth/4-20),
            height = (40),
            y = (display.actualContentHeight/8.5),
            shape = "roundedRect",
            fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
            onRelease = checkAnswer1,
        }
    )
    sceneGroup:insert(answerButton1)

    
    --Answer button 2
    function checkAnswer2()
        if chosenButton == 2 then
            speedUpCar()
            setQuestion()
        else
            slowDownCar()
            setQuestion()
        end
    end
    
    local answerButton2 = widget.newButton(
        {
            label = "",
            x = (3*display.actualContentWidth/8), 
            
            --universal properties of answer buttons
            labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
            font = Arial, 
            fontSize = 20,
            width = (display.actualContentWidth/4-20),
            height = (40),
            y = (display.actualContentHeight/8.5),
            shape = "roundedRect",
            fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
            onRelease = checkAnswer2,
        }
    )
    sceneGroup:insert(answerButton2)

    
    --Answer button 3
    function checkAnswer3()
        if chosenButton == 3 then
            speedUpCar()
            setQuestion()
        else
            slowDownCar()
            setQuestion()
        end
    end
    
    local answerButton3 = widget.newButton(
        {
            label = "",
            x = (5*display.actualContentWidth/8), 
            
            --universal properties of answer buttons
            labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
            font = Arial, 
            fontSize = 20,
            width = (display.actualContentWidth/4-20),
            height = (40),
            y = (display.actualContentHeight/8.5),
            shape = "roundedRect",
            fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
            onRelease = checkAnswer3,
        }
    )
    sceneGroup:insert(answerButton3)
    
    
    --Answer button 4
    function checkAnswer4()
        if chosenButton == 4 then
            speedUpCar()
            setQuestion()
        else
            slowDownCar()
            setQuestion()
        end
    end
    
    local answerButton4 = widget.newButton(
        {
            label = "",
            x = (7*display.actualContentWidth/8), 
            
            --universal properties of answer buttons
            labelColor = {default={0, 0.478, 1}, over={0, 0.478, 1}},
            font = Arial, 
            fontSize = 20,
            width = (display.actualContentWidth/4-20),
            height = (40),
            y = (display.actualContentHeight/8.5),
            shape = "roundedRect",
            fillColor = {default={0.86, 0.86, 0.86}, over={0.6, 0.6, 0.6}},
            onRelease = checkAnswer4,
        }
    )
    sceneGroup:insert(answerButton4)


---------------------------------------
----      Car and Track Setup      ----
---------------------------------------

    map = display.newGroup()
    sceneGroup:insert(map)
    
    
    --[[
        local mapy = display.actualContentHeight/1.4
    local mapx = (423 * mapy)/603
    local track = display.newImageRect(map, "Content/Levels/roundTrack.png", mapx, mapy)
    track.x, track.y = display.actualContentWidth/2, (display.actualContentWidth/1.05)
    print(track)
    --]]
    local mapy = 406.34921264648    
        
        
    local mapx = 285.05096435547                              --************************************************
    local track = display.newImageRect(map, "Content/Levels/" --Add the rest of the Level name Here , mapx, mapy)
                                                              --************************************************
            
            
    track.x, track.y = 160, 304.76190185547  --display.actualContentWidth/2, (display.actualContentWidth/1.05)

    local cary = 56.888891601562 --display.actualContentHeight/10
    local carx = 35.545639382845 --(448 * cary)/717
    car = display.newImageRect(map, "Content/Cars/" .. getCar(getCurrentUser()) .. ".png", carx, cary)
    car.x, car.y = 282.57189941406, 341.33334350586 --display.actualContentWidth/2 + track.width*0.43, (3*display.actualContentHeight/5) 
    
    
    
------------------------------
----      GAME LOGIC      ----
------------------------------
    local wrongAnswer = 0
    local wrongAnswer1 = 0
    local worngAnswer2 = 0
    local i = 0
    local looper = 0
    carSpeed = 0
    local tutorialCount = 0
    local answerPart1 = 0
    local answerPart2 = 0
    local finished = 0
    
    --Check Answers for duplicates    
    function checkPossibleAnswers()
        if((wrongAnswer == wrongAnswer2) or (wrongAnswer == wrongAnswer3) or (wrongAnswer == (answerPart1 * answerPart2)) or (wrongAnswer2 == wrongAnswer3) or (wrongAnswer2 == (answerPart1 * answerPart2)) or (wrongAnswer3 == (answerPart1 * answerPart2))) then 
            wrongAnswer = math.random(144)
            wrongAnswer1 = math.random(144)
            wrongAnswer2 = math.random(144) 
            checkPossibleAnswers()
        end
    end            
     
    --Sets the buttons such that one is correct and the rest are random    
    function setButtons()
        chosenButton = math.random(4)
        
        answerPart1 = math.random(12)
        answerPart2 = math.random(12)
        wrongAnswer = math.random(144)
        wrongAnswer1 = math.random(144)
        wrongAnswer2 = math.random(144)
        checkPossibleAnswers()
        
        if chosenButton == 1 then
            answerButton1:setLabel(tostring((answerPart1 * answerPart2)))
            answerButton2:setLabel(tostring(wrongAnswer))
            answerButton3:setLabel(tostring(wrongAnswer1))
            answerButton4:setLabel(tostring(wrongAnswer2))
        elseif chosenButton == 2 then
            answerButton2:setLabel(tostring((answerPart1 * answerPart2)))
            answerButton3:setLabel(tostring(wrongAnswer))
            answerButton4:setLabel(tostring(wrongAnswer1))
            answerButton1:setLabel(tostring(wrongAnswer2))
        elseif chosenButton == 3 then
            answerButton3:setLabel(tostring((answerPart1 * answerPart2)))
            answerButton4:setLabel(tostring(wrongAnswer))
            answerButton1:setLabel(tostring(wrongAnswer1))
            answerButton2:setLabel(tostring(wrongAnswer2))
        elseif chosenButton == 4 then
            answerButton4:setLabel(tostring((answerPart1 * answerPart2)))
            answerButton1:setLabel(tostring(wrongAnswer))
            answerButton2:setLabel(tostring(wrongAnswer1))
            answerButton3:setLabel(tostring(wrongAnswer2))
        end
        
    end
    
    --Sets the question text on the screen to the question
    function setQuestion()
        setButtons()
        local x = tostring(answerPart1) .. " x "
        questionText.text = ((x .. tostring(answerPart2)))
    end
    
    --Boosts the car 
    function speedUpCar()
        if carSpeed <= 10 then
            carSpeed = carSpeed + 0.5
        end
    end
     
    --Slows down the car
    function slowDownCar()
        if carSpeed >= 10 then
            carSpeed = carSpeed - 3
        end

    end
    
    
-------------------------------
----      Turns Object     ----
-------------------------------
    --Car Orientation vs degrees:
    --       0
    --       |
    --       |
    --270----+----90
    --       |
    --       |
    --      180
     
--Properties of turn:
    --endpoint (where on the coordinate system the car needs to stop while turning)
    --ammount (the angle of the turn, usually 90)
    --turnSpeed (equivelent to how sharp the turn is)
    --initialAngle (orientation of car before turn)
    --carOrientation (virticle v; horizontal h)
    --triggerPoint (when to turn on coordinate system)
    --carTriggerDirection (what side of the trigger point the turn happens (e.g. if the car is going up to a turn or down))
    

    
    local function turn(ammountIn, endpointIn, turnSpeedIn, initialAngleIn, carOrientationIn, triggerPointIn, carTriggerDirectionIn)
        local self = {}
        
        local ammount = ammountIn
        local endpoint = endpointIn
        local turnSpeed = turnSpeedIn
        local initialAngle = initialAngleIn
        local carOrientation = carOrientationIn
        local triggerPoint = triggerPointIn
        local carTriggerDirection = carTriggerDirectionIn
        
        function self.returnAngleV()
            car.rotation = (initialAngle + turnSpeed * (ammount * math.abs((car.y - triggerPoint)/(endpoint - triggerPoint))))
        end 
    
        function self.returnAngleH()
            car.rotation = (initialAngle + turnSpeed * (ammount * math.abs((car.x - triggerPoint)/(endpoint - triggerPoint))))
        end 
        
        function self.getFinalAngle()
           car.rotation = (initialAngle + ammount)
        end    
        
        function self.getTurnAngle()                                                                                      --   Turn Funciton
               if carOrientation == "v" then                                                                               --   |-- Car is turning from virticle position
                   if carTriggerDirection == "up" then                                                                     --   |   |-- Car is facing up 
                       if car.y <= triggerPoint then                                                                       --   |   |   |-- Car is above trigger
                           if car.y <= (endpoint + 15) and round(car.rotation, 0) == (initialAngle + ammount) then         --   |   |   |   |-- Car is below endpoint
                               return true                                                                                 --   |   |   |   |   |-- turn complete
                                                                                                                           --   |   |   |   |
                           else                                                                                            --   |   |   |   |-- Car is above endpoint
                               self.returnAngleV()                                                                         --   |   |   |       |-- Car starts to turn
                           end                                                                                             --   |   |   | 
                       end                                                                                                 --   |   |   |-- Turn doesn't start yet
                                                                                                                           --   |   |
                   elseif carTriggerDirection == "down" then                                                               --   |   |-- Car is facing down
                       if car.y >= triggerPoint then                                                                       --   |   |   |-- Car is below trigger
                           if car.y >= (endpoint - 15) and round(car.rotation, 0) == (initialAngle + ammount) then         --   |   |-- Car is above endpoint
                               return true                                                                                 --   |   |   |   |   |-- Returns true to mark turn complete
                                                                                                                           --   |   |   |   |
                           else                                                                                            --   |   |   |   |-- Car is below endpoint
                               self.returnAngleV()                                                                         --   |   |   |       |-- Car starts to turn
                           end                                                                                             --   |   |   | 
                       end                                                                                                 --   |   |   |-- Car is above trigger, turn doesn't start yet
                   end                                                                                                     --   |   |
                                                                                                                           --   |
               elseif carOrientation == "h" then                                                                           --   |-- Car is turning from horizontal position
                   if carTriggerDirection == "right" then                                                                  --   |   |-- Car is facing right 
                       if car.x >= triggerPoint then                                                                       --   |   |   |-- Car is right of the trigger
                           if car.x >= (endpoint - 15) and round(car.rotation, 0) == (initialAngle + ammount) then         --   |   |-- Car is right of endpoint
                               return true                                                                                 --   |   |   |   |   |-- Returns true to mark turn
                                                                                                                           --   |   |   |   |
                           else                                                                                            --   |   |   |   |-- Car is left of endpoint
                               self.returnAngleH()                                                                         --   |   |   |       |-- Car starts to turn complete
                           end                                                                                             --   |   |   | 
                       end                                                                                                 --   |   |   |-- Car is left of trigger, turn doesn't start yet
                                                                                                                           --   |   |
                   elseif carTriggerDirection == "left" then                                                               --   |   |-- Car is facing left
                       if car.x <= triggerPoint then                                                                       --   |   |   |-- Car is left of the trigger
                           if car.x <= (endpoint + 15) and round(car.rotation, 0) == (initialAngle + ammount) then         --   |   |-- Car is right endpoint
                               return true                                                                                 --   |   |   |   |   |-- Returns true to mark turn complete
                                                                                                                           --   |   |   |   |   
                           else                                                                                            --   |   |   |   |-- Car is left endpoint
                               self.returnAngleH()                                                                         --   |   |   |   |   |-- Car starts to turn
                           end                                                                                             --   |   |   |       
                       end                                                                                                 --   |   |   |-- Car is right of trigger, turn doesn't start yet
                   end                                                                                                     --   |   |   |
               end                                                                                                         --   |   |
           end                                                                                                             --   |
           
               return self        
           end 
          
     
   ------------------------------------------
   --            Creating turns            --
   ------------------------------------------
   --[[ To add the turns to a level, create a new global called turn1, and increment for ever turn there on. Using the comments bellow,
    Add each property of turn, and if necessary, refering to the above section, turn object, for extra reference.
   ]]--
            
--Properties of turn:
    --endpoint (where on the coordinate system the car needs to stop while turning)
    --ammount (the angle of the turn, usually 90)
    --turnSpeed (equivelent to how sharp the turn is)
    --initialAngle (orientation of car before turn)
    --carOrientation (virticle v; horizontal h)
    --triggerPoint (when to turn on coordinate system)
    --carTriggerDirection (what side of the trigger point the turn happens (e.g. if the car is going up to a turn or down))
           
            
   --Here is an example, the turns needed for the tutorial level.
   --turn1 = turn(-90, 120, 1, 360, "v", 155, "up")
   --turn2 = turn(-90, 105, 1, 270, "h", 70, "left")
   --turn3 = turn(-90, 420, 1, 180, "v", 455, "down")
   --turn4 = turn(-90, 285, 1, 90, "h", 250, "right")   
            
            
            
            
    local turnCounter = 1
    
    function winCondition(dimension, dirrection, position) --(the axis, the coordinate the car needs to pass, the dirrection the car is going in) 
        if dimension == "x" then
           if dirrection == "left" then
                if car.x <= position then return true end
            elseif dirrection == "right" then
                if car.x >= position then return true end end       
        elseif dimension == "y" then
            if dirrection == "up" then
                if car.y <= position then return true end
            elseif dirrection == "down" then
                if car.y >= position then return true end end 
        end 
    end
    
    
    local milis = 0
    local incrementMilis = 0.1
    local watch
    
    
    function t:timer(event)
        if freezeTime == true then 
            timer.cancel(event.source)
        else
                milis = milis + incrementMilis
            tutorialText.text = "Time: " .. milis
        end
        --Have some condition to cancel the timer to avoid it running forever

    end
    

    function winNotification(event)
        --hides navigation bar on android
        if system.getInfo( "androidApiLevel" ) and system.getInfo( "androidApiLevel" ) < 19 then
            native.setProperty( "androidSystemUiVisibility", "lowProfile" )
        else
            native.setProperty( "androidSystemUiVisibility", "immersiveSticky" ) 
        end
        
        --Starts to move the car once the okay button is clicked on the welcome notification    
        if(event.action == "clicked") then
            local p = event.index
            if p == 1 then
                composer.gotoScene("loggedInScreen")
            end
        end
    end
    
    local gameWon = false
    local turnNameString = ""
    function doTurns(count)
        
        if turnCounter <= count then
            turnNameString = "turn" .. tostring(turnCounter) --Sets name of turn; turn1, turn2, etc..
            
            _G[turnNameString].getTurnAngle()
            
            
            if _G[turnNameString].getTurnAngle(turnNameString) == true then --Turn incrementation logic
                _G[turnNameString].getFinalAngle()
                turnCounter = turnCounter + 1
            end 
            
        elseif winCondition("y", "up", 300) then
            if gameWon == false then
                gameWon = true
                local timeString = ""
                freezeTime = true
                local welcomeMessage = "Congratulations, " .. getCurrentUser() .. "!"
                if checkAndUpdate(milis) then
                    timeString = "You beat your previous time!"
                else 
                    timeString = " You did not beat your previous time."
                end
                native.showAlert(welcomeMessage, "Your time was " .. milis .. " seconds." .. timeString, {"OK"}, winNotification)
            end
            turnCounter = 1
        end                    
    end  
    


-----------------------------------------------
------      EVENT LISTENER ON FRAME      ------
-----------------------------------------------
--This executes every frame and moves the car around the track.         
    local currentTime
    function carMovement()
        doTurns(4)
            
        if gameWon == false then
            if(carSpeed > 0.3) then 
                carSpeed = carSpeed - 0.002  
            else
                carSpeed = 0.3 
            end 
        end
            
        local angle = math.rad(car.rotation)
        car.x = car.x + (math.sin(angle)*carSpeed)
        car.y = car.y - (math.cos(angle)*carSpeed)
        
     end
   

    
    --trigger every 100ms, call 'updateTime' function, and loop forever (-1)
    
        
        -- Called when the scene is still off screen (but is about to come on screen).
        
    elseif ( phase == "did" ) then
        --Funciton that is performed once the welcome notification is dismissed
        function notidismis(event)
             watch = timer.performWithDelay( 100, t, 0 )
            --hides navigation bar on android
            if system.getInfo( "androidApiLevel" ) and system.getInfo( "androidApiLevel" ) < 19 then
                native.setProperty( "androidSystemUiVisibility", "lowProfile" )
            else
                native.setProperty( "androidSystemUiVisibility", "immersiveSticky" ) 
            end

            --Starts to move the car once the okay button is clicked on the welcome notification    
            if(event.action == "clicked") then
                local p = event.index
                if p == 1 then
                    setQuestion()
                    Runtime:addEventListener("enterFrame", carMovement)   
                end
            end
        end
        
        local welcomeMessage = "Welcome, " .. getCurrentUser()
        native.showAlert(welcomeMessage, "To play the game, choose the correct answer and try to get to the finish line as fast as possible.", {"OK"}, notidismis)
            
    end
    
    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
     
end

--------------------------------------------------------------------------------
-- "scene:hide()"
--------------------------------------------------------------------------------
function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    Runtime:removeEventListener("enterFrame", carMovement)
    tutorialText.text = ""
    questionText.text = ""
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
