# Requirements

Fracture is a fairly specific library. It makes certain assumptions about how your project is structured, and expects a few things to be prepared before you fracture anything.

---

Keep the following in mind for it to work as expected:

- Room Physics must be enabled in any room where Fracture is used.
  ::: warning
  Enabling Room Physics disables GameMaker's built-in motion system. None of the motion [variables](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/Instance_Variables/Instance_Variables.htm) or [functions](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Movement_And_Collisions/Movement/Movement.htm#:~:text=ystart-,Functions,-The%20following%20functions) will work with physics enabled. This is a GameMaker limitation that's not specific to Fracture - motion system and Box2D physics are [mutually exclusive](https://manual.gamemaker.io/lts/en/The_Asset_Editors/Room_Properties/Room_Properties.htm#:~:text=These%20systems%20are%20mutually%20exclusive%2C%20and%20you%20cannot%20move%20a%20physics%20instance%20using%20non%2Dphysics%20functions%20and%20you%20cannot%20move%20a%20non%2Dphysics%20instance%20using%20the%20physics%20functions.).
  :::
- Only instances with a valid sprite assigned can be fractured.
- Instances with negative [image_xscale](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Instance_Variables/image_xscale.htm) or [image_yscale](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Instance_Variables/image_yscale.htm) cannot currently be fractured. Negative scale support is planned for a future version.
- All Pieces render on a single shared layer or depth, so depth sorting with other instances is not supported. Fracture targets sidescrollers, space shooters, and other perspectives where depth sorting is not a concern.
- Fracture doesn't create any world geometry for you, and you'll need walls or colliders with physics fixtures for Pieces to collide and bounce against. If your walls aren't physics-enabled, Pieces will only collide with each other and fall straight through the map.
