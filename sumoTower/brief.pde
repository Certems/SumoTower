/*
Basic structure of game
------------------------
.Composed of multiple stages
.Each stage involves many cycles in which a player and AI fight
.Fights are won based on positional conditions
.Wins result in moving onto later stages
.Loses result in reset progress
.Player improves (via new abilities) as they win

Terminology
-----------
. stage     = scenario in which cycles occur until the player wins or loses
. cycle     = all actions processed and conflicts resolved
. conflict  = sumos interact with eachother via an ability
. board     = grid the game is played on
. sumo      = character on the board that can perform actions (player and AI)
. 

File structure
--------------
Manager
->Handles overall graphics and calculation, using the results from its 
  sub classes and the information they find
    holds game states (each classes)
    ->These handle the graphics and calculations 
      separately for everything within its scope
        holds small info holding classes (e.g sumos, tiles)
        ->These just hold their own individual information that can be 
          accessed by the state class above it

.Focus is on updating only information that needs to be updated
e.g.redrawing items that either moveing or are behind a moving item, and leaving everything
    static alone
.Multiple states can be active at once, and overlay according to their position in the state list
*/