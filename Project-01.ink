/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

VAR cycle_count = 0
VAR armor = 0
VAR wins = 0
VAR losses = 0

-> start

== start == 
You and your friends have decided to play Highguard the new 3v3 raid shooter.
* [AWESOME I LOVE THAT GAME] -> positive
* [BOOOOO I HATE THAT GAME] -> preparation_phase

== positive ==
-> preparation_phase

== preparation_phase ==
{wins >= 2: -> game_win}
{losses >= 2: -> game_loss}

{sword_fight: The score is {wins} to {losses}!! | {positive: You are filled with enthusiasm as you begin to reinforce your base. | You are filled with dread as you begin to reinforce your base.}}

Should you use your reinforcements on generator A, B, or on the main heart?
* [A] -> a_reinforce
* [B] -> b_reinforce
* [Heart] -> c_reinforce



== a_reinforce ==
You reinforced the A generator.
-> sword_phase

== b_reinforce ==
You reinforced the B generator.
-> sword_phase

== c_reinforce ==
You reinforced the main heart.
-> sword_phase

== sword_phase ==
It is now time to fight for the Shieldbreaker. A sword with the capability to break into the opposing teams base.

Should you ride directly to it and fight or buy armor?
+ [Direct Path] -> sword_fight
+ [Buy Armor on the way] { add_armor() } -> sword_fight

== sword_fight ==
{ armor > cycle_count: You had more armor than the enemy and won the fight for the shield breaker!! Should you pick it up or give it to a teammate?| You lost the fight for the shield breaker because you didn't buy armor...}

+ {armor>cycle_count} [Pick it up yourself!] -> sword_pickup
+ {armor>cycle_count} [Let a teammate pick it up!] -> teammate_sword_pickup
+ {armor<=cycle_count} [Retreat to home base and defend our generators] -> raid_defend_decision

== sword_pickup ==
You pick up the sword and plant it on the enemy base!!
-> raid_attack

== teammate_sword_pickup ==
Your Redmane teammate picks up the sword and plants it on the enemy base!
-> raid_attack

== raid_attack ==
The raid has now begun. Which part of the enemy base do you want to attack?
* [Generator A] -> a_attack
* [Generator B] -> b_attack
* [Main Heart] -> c_attack

== a_attack ==
You successfully destroyed generator A giving your team a successful raid and a win on the board!!
{add_win()}
* [Go to next round] {add_cycle_count()} -> preparation_phase

== b_attack ==
You successfully destroyed generator B giving your team a successful raid and a win on the board!!
{add_win()}
* [Go to next round] {add_cycle_count()} -> preparation_phase

== c_attack ==
You got to greedy and all died trying to take out the heart of the base... an unsuccessful raid results in a loss...
{add_loss()}
* [Go to next round] {add_cycle_count()} -> preparation_phase

== raid_defend_decision ==
{ cycle_count == 0: -> a_defend}
{ cycle_count == 1: -> b_defend}
{ cycle_count == 2: -> c_defend}

== a_defend ==
The enemy team is attacking your generator A!!
{ a_reinforce: Since you reinforced generator A you were able to hold them off giving you a successful defense and a win!! { add_win() } | You didn't reinforce generator A causing your team to be overwhelmed and losing the generator... { add_loss() }} 

The next round is starting...
+ [Go to next round] {add_cycle_count()} -> preparation_phase

== b_defend ==
The enemy team is attacking your generator B!!
{ b_reinforce: Since you reinforced generator B you were able to hold them off giving you a successful defense and a win!! { add_win() } | You didn't reinforce generator A causing your team to be overwhelmed and losing the generator... { add_loss() }} 

The next round is starting...
+ [Go to next round] {add_cycle_count()} -> preparation_phase

== c_defend ==
The enemy team is attacking your base heart this defense is the final decider of the match!!
* [Lock in and win] {add_win()} -> preparation_phase
* [Give up and lose the other team deserves the win...] {add_loss()} -> preparation_phase

== game_win ==
YOU WON!!!!
->  DONE

== game_loss ==
YOU LOST!!!
-> DONE

== function add_armor ==
~ armor = cycle_count + 1


== function add_win ==
~ wins = wins + 1


== function add_loss ==
~ losses = losses + 1

== function add_cycle_count ==
~ cycle_count = cycle_count + 1




