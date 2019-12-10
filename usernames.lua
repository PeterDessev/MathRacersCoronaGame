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
 
local tableSetup = [[CREATE TABLE IF NOT EXISTS users ( UserID INTEGER PRIMARY KEY autoincrement, name, car, timeLevel1);]] 




--DELETES TABLE: WARNING!!
--local tableSetup = [[DROP TABLE users]]

function createUser( user )
    local q = [[INSERT INTO users VALUES ( NULL, "]] .. tostring(user) .. [[", "redCar", 10000);]]
    db:exec( q )
    return true 
end

function setTime( time )
    local q = [[UPDATE users SET timeLevel1=]] .. time .. [[ WHERE name="]] .. getCurrentUser() .. [[";]]
    db:exec( q )
    return true
end

function getTime( user )
    for row in db:nrows("SELECT * FROM users") do 
        if(row.name == user) then
            
            if tonumber(row.timeLevel1) <= 1000 then
                return row.timeLevel1
            else
                return (" No time recorded.")
            end
        end
    end
    createUser(getCurrentUser())
    return (" No time recorded, user not found, created new user...")

end

function initiateTable()
    db:exec( tableSetup )
end

function checkAndUpdate( inputTime )
    local people = {} 
    for row in db:nrows( "SELECT * FROM users" ) do
        people[#people+1] =
        {
            Name = row.name,
            Time = row.timeLevel1
        }
        if people[#people].Name == getCurrentUser() then
            print("found User")
            if tonumber(people[#people].Time) > inputTime or people[#people].Time== nil then
                print("user beat previous time")
                people[#people].Time = inputTime
                local q = [[UPDATE users SET timeLevel1=]] .. inputTime .. [[ WHERE name="]] .. people[#people].Name .. [[";]]
                db:exec( q )
                print("Current time: " .. getTime(people[#people].Name))
                return true
            else return false end
        end
    end
end

function getAllTimes()
    local people = {}
    for row in db:nrows( "SELECT * FROM users" ) do
--        print(row.name, row.timeLevel1)
        people[#people+1] =
        {
            Name = row.name,
            Time = row.timeLevel1
        }
    end
    if people == nil then
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
    end
    if car == nil then
        return "no car"
    else
        print("current car is " .. car)
        return car
    end 
end

function setCar(car)
    local q = [[UPDATE users SET car="]] .. tostring(car) .. [[" WHERE name="]] .. tostring(getCurrentUser()) .. [[";]]
    db:exec( q )
    print("set " .. getCurrentUser() .. "'s car to " .. getCar(getCurrentUser()))
    return true
end