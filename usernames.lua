 local composer = require( "composer" )
local GBCDataCabinet = require("plugin.GBCDataCabinet")
local sqlite3 = require( "sqlite3" )



--Leaderboard GoBack Logic
local leaderboardOrigin = ""

function setLeaderboardOrigin(origin)
    leaderboardOrigin = origin
end

function getLeaderboardOrigin()
    return leaderboardOrigin
end


--Users and Passwords
local success = GBCDataCabinet.load("Users")
if success == false then
    success = GBCDataCabinet.createCabinet("Users")
    GBCDataCabinet.set("Users", "user1", "1")
end

function checkInitUsers()
    return success    
end


function addUser(key, value)
    GBCDataCabinet.set("Users", key, value)
    GBCDataCabinet.save("Users")
end

function removeUser(key)
    GBCDataCabinet.set("Users", key, nil)
    GBCDataCabinet.save("Users")
end

function getUser(key)
    return GBCDataCabinet.get("Users", key)
end




--Current User
local currentUser = ""

function setCurrentUser(user)
    currentUser = user
end

function getCurrentUser()
    return currentUser
end

function logOutUser()
    currentUser = ""
    composer.gotoScene("logInScene")
end




--Scores and such
local path = system.pathForFile( "level1Times.db", system.DocumentsDirectory )
local db = sqlite3.open( path ) 
 
local tableSetup = [[CREATE TABLE IF NOT EXISTS users ( UserID INTEGER PRIMARY KEY autoincrement, name, car, Level1, Level2);]] 




--DELETES TABLE: WARNING!!
--local tableSetup = [[DROP TABLE users]]

function createUser( user )
    print(type(user), user)
    local q = [[INSERT INTO users VALUES ( NULL, "]].. tostring(user) .. [[", "redCar", 10000, 10000);]]
    db:exec( q )
    return true 
end

function setTime( time )
    local q = [[UPDATE users SET Level1=]] .. time .. [[ WHERE name="]] .. getCurrentUser() .. [[";]]
    db:exec( q )
    return true
end

function getTime( user, level)
    for row in db:nrows("SELECT * FROM users") do 
        if(row.name == user) then
            if level == "Level 1" then
                if tonumber(row.Level1) <= 100 then
                    return row.Level1
                else
                    return (" No time recorded.")
                end
            elseif level == "Level 2" then
                if tonumber(row.Level2) <= 100 then
                    return row.Level2
                else
                    return (" No time recorded.")
                end
            end
        end
    end
    createUser(getCurrentUser())
    return (" No time recorded, user not found, created new user...")

end

function initiateTable()
    db:exec( tableSetup )
end

function checkAndUpdate( inputTime, level )
    local people = {} 
    for row in db:nrows( "SELECT * FROM users" ) do
        if level == "Level 1" then
            people[#people+1] =
            {
                Name = row.name,
                Time = row.Level1
            }
            if people[#people].Name == getCurrentUser() then
                print("found User")
                if tonumber(people[#people].Time) > inputTime or people[#people].Time== nil then
                    print("user beat previous time")
                    people[#people].Time = inputTime
                    local q = [[UPDATE users SET Level1=]] .. inputTime .. [[ WHERE name="]] .. people[#people].Name .. [[";]]
                    db:exec( q )
                    print("Current time: " .. getTime(people[#people].Name, level))
                    return true
                else return false end
            end
        elseif level == "Level 2" then
            people[#people+1] =
            {
                Name = row.name,
                Time = row.Level2
            }
            if people[#people].Name == getCurrentUser() then
                print("found User")
                if tonumber(people[#people].Time) > inputTime or people[#people].Time == nil then
                    print("user beat previous time")
                    people[#people].Time = inputTime
                    local q = [[UPDATE users SET Level2=]] .. inputTime .. [[ WHERE name="]] .. people[#people].Name .. [[";]]
                    db:exec( q )
                    print("Current time: " .. getTime(people[#people].Name, level))
                    return true
                else return false end
            end
        end
    end
end

function getAllTimes(level)
    local people = {}
    print("")
    print("Getting times for " .. level)
    print("+-------------------------------------")
    for row in db:nrows( "SELECT * FROM users" ) do
        print("| " .. row.name, "   Level 1: " .. row.Level1, "  Level 2:" .. row.Level2)
        print("+-------------------------------------")
        if level == "Level1" then
            --print("Getting times from Level 1")
            people[#people+1] = {
                Name = row.name,
                Time = row.Level1
            }
        elseif level == "Level2" then
            --print("Getting times from Level 2")
            people[#people+1] = {
                Name = row.name,
                Time = row.Level2
            }
        end
    end
        
--[[print(level)
    local Names = {}
    local Times = {}
    
    local people
    for row in db:nrows( "SELECT * FROM users" ) do
        print(row.name, row.Level1, row.Level2)
        Names[#Names+1] = row.name
    end
    print(#Names)
    if #Names ~= 0 then people = {} end
    for row in db:nrows( "SELECT Level1 FROM users" ) do
        print()
        Times[#Times+1] = row[1]
        people[#Times] = {Names[#Times], Times[#Times]}
    end
    --]]
    if people[1].Name == nil then
        return "no Scores"
    else
--        print("scores found")
        return people
    end
end

function getCar(user)
    local car
    for row in db:nrows( "SELECT * FROM users" ) do
        car = row.car
        people = row.name
        if people == user then
            if car == nil then
                print("no car")
                return "no car"
            else
                print("current car is " .. car)
                return car
            end
        end
    end 
end

function setCar(car)
    local q = [[UPDATE users SET car="]] .. tostring(car) .. [[" WHERE name="]] .. tostring(getCurrentUser()) .. [[";]]
    db:exec( q )
    print("set " .. getCurrentUser() .. "'s car to " .. getCar(getCurrentUser()))
    return true
    end