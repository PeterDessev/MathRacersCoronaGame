local composer = require( "composer" )
local scene = composer.newScene()
local track, car, background
local widget = require("widget")
local usernames = require("usernames")

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
  local tutorialTextOptions = {
            text = "Tutorial",
            font = Arial,
            fontSize = 30,
            --fillColor = (0,0,0),
            x = display.actualContentWidth/2,
            y = 0,
        }
        
    local tutorialText = display.newText(tutorialTextOptions)
    sceneGroup:insert(tutorialText)
    tutorialText:setFillColor(0,0,0)
    
    
    local questionTextOptions = {
            text = "",
            font = Arial,
            fontSize = 25,
            --fillColor = (0,0,0),
            x = display.actualContentWidth/2,
            y = display.actualContentHeight/20,
        }
    
    local questionText = display.newText(questionTextOptions)
    sceneGroup:insert(questionText)
    questionText:setFillColor(0,0,0)
    

--Answer Buttons
    local chosenButton = 0

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
    ]]
    local mapy = 406.34921264648
    local mapx = 285.05096435547
    local track = display.newImageRect(map, "Content/Levels/Tutorial.png", mapx, mapy)
    track.x, track.y = 160, 304.76190185547  --display.actualContentWidth/2, (display.actualContentWidth/1.05)

    local cary = 56.888891601562 --display.actualContentHeight/10
    local carx = 35.545639382845 --(448 * cary)/717
    local car = display.newImageRect(map, "Content/Cars/redCar.png", carx, cary)
    car.x, car.y = 282.57189941406, 341.33334350586 --display.actualContentWidth/2 + track.width*0.43, (3*display.actualContentHeight/5) 
    
------------------------------
----      GAME LOGIC      ----
------------------------------
    local wrongAnswer = 0
    local wrongAnswer1 = 0
    local worngAnswer2 = 0
    local i = 0
    local looper = 0
    local carSpeed = 0
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
        else end
    end            
            
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
    
    
    function setQuestion()
        setButtons()
        local x = tostring(answerPart1) .. "x"
        questionText.text = ((x .. tostring(answerPart2)))
    end
    
    
    function speedUpCar()
        if carSpeed <= 10 then
            carSpeed = carSpeed + 0.5
        end
    end
     
    function slowDownCar()
        if carSpeed >= 10 then
            carSpeed = carSpeed - 1
        end

    end
    
    
 --change axis to turn number later
    function turn(axis, endpoint, ammount)
            if(axis == "y") then
                car.rotation = 360 - 2.2 * (ammount*((endpoint-car.y)/car.y))
            elseif(axis == "x")then
                car.rotation = 270 - (0.8) * (ammount*((endpoint-car.x)/(car.x)))
            elseif(axis == "-y") then
                car.rotation = 180 + 13.5 * (ammount*((endpoint-car.y)/car.y))
            elseif(axis == "-x") then
                car.rotation = 90 + 7 * (ammount*((endpoint-car.x)/car.x))
            end
    end
  
 
    function carMovement() 
        
        if(carSpeed > 0.3) then
            carSpeed = carSpeed - 0.002  
        else
            carSpeed = 0.3 
        end 
                
        local angle = math.rad(car.rotation)
        car.x = car.x + (math.sin(angle)*carSpeed)
        car.y = car.y - (math.cos(angle)*carSpeed)
        
        local turn1K = 170.66666931152 --2.1*track.height/5
        if(car.y <= (turn1K) and car.rotation ~= 270) then 
            turn("y", turn1K, 90) 
        end
        
        local turn2K = 83.2 --1.3*display.actualContentWidth/5
        if(car.x <= (turn2K) and car.rotation ~= 180) then 
            turn("x", turn2K, 90) 
        end
        
        local turn3K = 455.1111328125 --4.0*display.actualContentHeight/5
 
        if(car.y >= (turn3K) and car.rotation ~= 90) then 
            turn("-y", turn3K, 90) 
        end
        
        local turn4K = 243.2 --3.8*display.actualContentWidth/5
        if(car.x >= (turn4K) and car.rotation <=180) then 
            turn("-x", turn4K, 90) 
        end
        
        if(car.y >= 342 and car.y <= 345 and car.x > 250)then
            function victoryStuff()
               composer.gotoScene("loggedInScreen") 
            end
            
            native.showAlert("You Won!", "Congratulations on completing the tutorial, now, go win some races!", {"OK"}, victoryStuff)
        end
     end
--[[    answerButton1.text = toString(answerPart1 * answerPart2)
        answerButton2.text = toString(wrongAnswer)
        answerButton3.text = toString(wrongAnswer1)
        answerButton4.text = toString(wrongAnswer2)
--]]
    
end    


--------------------------------------------------------------------------------
-- "scene:show()"
--------------------------------------------------------------------------------
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    -- Called when the scene is still off screen (but is about to come on screen).
        
    elseif ( phase == "did" ) then
    
        function notidismis(event)
            if system.getInfo( "androidApiLevel" ) and system.getInfo( "androidApiLevel" ) < 19 then
                native.setProperty( "androidSystemUiVisibility", "lowProfile" )
            else
                native.setProperty( "androidSystemUiVisibility", "immersiveSticky" ) 
            end
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
