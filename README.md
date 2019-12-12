# Math Racers Corona Game
An educational game designed to help students with their mathematical abilities


## Files
Each screen is its own file. Detailed below are key screens, other files and folders, and their respective purposes.

### Screens:
logInScene.lua - The default screen that the app shows on startup, allows users to view leaderboard, create and log into an account

createAccountScreen.lua - This screen allows users to create accounts.

loggedInScreen.lua - Once a user has successfully logged in, they will be brought to this screen, from which a level may be selected among other things.

settingsScreen.lua - to navigate to this screen, press the three bar icon in the top right of the logged in screen. Here the user can change which car you are using, or log out. Logging out will bring the user back to the log in screen.

### Other files:
usernames.lua - this file is not used as a screen, instead as an intermediate between the database of all the user info, and the rest of the game. Whenever adding new funcitons that are user specific, add them here.

main.lua - When importing the project into Corona, this will be the file Corona asks for. 

## Folders
these are the other important folders that control how the game works and looks.

### Content:
Here is where all the game images are store, such as the levels or the cars.

### Game Levels:
Here the lua files for each of the levels are stored. Each level is named according to its duificulty

level(TEMPLATE).lua - This file is not used in the actual game, but is the template for creating a new level, along with instructions in-file on how to do so. Remember to update usernames.lua and add the extra level to the database, its surrounding methods, and then reloading it by deleting and recreating it.
