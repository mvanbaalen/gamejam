# GitHub Game Jam November 2018

Link to the Game Jam description:

https://blog.github.com/2018-11-01-game-off-2018-theme-announcement/

The theme is **Hybrid**.

Current ideas:
1. Interpret as a hybrid between two game genres (preferable two that haven't been done before)
 like a text-based fighting game, working title **Tekten**:
 ![Tekten concept scene](/img/texten_concept_scene.png)
 
 Players fight like a regular side-fighter, but they must enter each command into the prompt and press enter to execute.
 
 **Example Commands**
 
 key | action
 ---- | ----
 w,a,s,d | move, duck, jump
 A,D | dash
 z,x | move set (keys could be character dependent?)
 Z,X | strong move set
 wwssz | combo example
 zzzx | combo example
 gw | grab up
 gs | grab down
 gd | grab far (right facing player)
 b | block
 cz | counter ONLY if hit with z
 cx | counter ONlY if hit with x
 fire! | special move example
 water! | special move example
 bz | if enemy is blocking, successfully hit with z. if not blocking, be stunned.
 x,x,x | hit this x 3 times with pauses between (comma is combo delimiter)
 p | pause
 q | quit (only when paused)
 t | taunt
 m5 | change music to song 5

Things we need:
* Undertanding of fighting game mechanics
* A simple command parser
* character art (Maybe just one character with a palette swap? keep it simple)
  * Idle
  * x-move, z-move
  * walk
  * jump
  * duck
  * ground
  * damage
  * air damage
* Stages (2~3)
  * ground
  * background (near)
  * bacground (far)
* SFX visuals
* Simple menu structure
* Music (~10 songs)
