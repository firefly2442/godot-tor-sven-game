# godot-tor-sven-game

## About

A [Godot](https://godotengine.org) game for Tor and Sven!

## Controls

This is a cooperative game intended for two players.
Both the keyboard and XBox controller are supported as inputs.

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
* Use `Debug -> Visible Collision Shapes` for debugging collisions and physics
* Built and tested against Godot `4.5.1`
* [Godot CI](https://github.com/abarichello/godot-ci) used for Github automated builds

## License

* Sourcecode - [Creative Commons 0](https://creativecommons.org/public-domain/cc0/)
* Art/Images/Models - [Creative Commons 0](https://creativecommons.org/public-domain/cc0/)
  * [Kenney.nl](https://kenney.nl)
* Sound/Audio/Music - [Creative Commons 0](https://creativecommons.org/public-domain/cc0/)
  * [Freesound.org](https://freesound.org)

## References and Links

* [Godot Tutorials](https://www.youtube.com/channel/UCnr9ojBEQGgwbcKsZC-2rIg)
* [GDQuest](https://www.youtube.com/c/Gdquest)
* [KidsCanCode](https://www.youtube.com/c/KidscancodeOrg)
* [WebTyler](https://wareya.github.io/webtyler/)
* [Godot Tilemaps](https://www.youtube.com/watch?v=_SSInMAWd3g)
* [Godot Tilemap Physics Tutorial](https://www.youtube.com/watch?v=19rY6kzt_Rs)
* [Official Godot Demos Github](https://github.com/godotengine/godot-demo-projects)
* [Godot Autobattle Tutorial](https://www.youtube.com/playlist?list=PL6SABXRSlpH_0UEV3gJ53I7a2eGL8pqs3)
* [Godot Autobattle Github](https://github.com/guladam/godot_autobattler_course)
* [Godot Card Game Tutorial](https://www.youtube.com/watch?v=ulgh_neTJG8&list=PL6SABXRSlpH8CD71L7zye311cp9R4JazJ)
* [Godot Card Game Github](https://github.com/guladam/deck_builder_tutorial/tree/season-1-starter-project)
