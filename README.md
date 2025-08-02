# godot-tor-sven-game

## About

A Godot game for Tor and Sven!

## Developer Notes

* Use signals to promote information up a tree
* CTRL + SHIFT + O to quick open a scene
* Bullets/projectiles/lasers etc. need to be pointed by default to the right
* Use [composition](https://www.youtube.com/watch?v=JJid46XzW8A) to [separate
out core](https://www.youtube.com/watch?v=rCu8vQrdDDI) functionality and re-use it between
scenes and entities.
* Setup [required static typing](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/static_typing.html#warning-system)
as a project setting.  Also enable `Editor -> Editor Settings -> Text Editor -> Completion -> Add Type Hints`
* To prevent `CharacterBody2D` objects from "sticking" to each other, change "Motion Mode"
from "Grounded" to "Floating".
* Use "modulate" on sprites to set the color
* Use Parallax backgrounds to move items in the background at a slower speed
* Use `##` for comments and to do variable documentation in GDScript
* Built for 1920x1080 resolution, changes may break the game
* Keyboard and controller supported

## Youtube Channels

* [Godot Tutorials](https://www.youtube.com/channel/UCnr9ojBEQGgwbcKsZC-2rIg)
* [GDQuest](https://www.youtube.com/c/Gdquest)
* [KidsCanCode](https://www.youtube.com/c/KidscancodeOrg)
* [WebTyler](https://wareya.github.io/webtyler/)
* [Godot Tilemaps](https://www.youtube.com/watch?v=_SSInMAWd3g)
* [Godot Tilemap Physics Tutorial](https://www.youtube.com/watch?v=19rY6kzt_Rs)
