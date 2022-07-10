# PhysicalKeyboardVR-godot3-5

Attempt at protyping a VR keyboard with physical keys, only for use with Godot 3.5+

<img src="./physicalkeyboard.gif" alt="Keyboard GIF" width="480" height="272">
 
This is an attempt at creating a physical keyboard to use when "faux physics hands" or perhaps someday real physics hands, are used in a game

The understanding for how this might be possible came from MalcolmNixon's VirtualKeyboard included in XR-Tools.

That keyboard uses a Viewport2Dto3D node and hand pointers to work.

This physical keyboard uses the new Label3D functionality in Godot 3.5+ to obviate the need for viewports.

It uses the FollowBone3D approach to faux physics hands to physically click the buttons.  https://github.com/teddybear082/FollowBone3D

The basis for the keyboard buttons is MalcolmNixon's push button in the experiemental XR-tools-interactables repository. https://github.com/Malcolmnixon/godot-xr-tools-interactables

By default, the keys have a layer of 19.  The idea is that the physics hands fingers would have a mask of 18 and 19, while the physics hands palms would just have a mask of 18.

Mask 18 would be thus be used for all non-keyboard items the player wants to interact with in the game by poking them.

This allows both palms and fingers to be used for those items.

Mask 19 would be used for JUST the keyboard.  This prevents the physics palms from interfering while typing.

##Demo Scene

To test it out, just download the code zip, open in Godot in Godot 3.5 or more, and everything should work out of the box.

##To Use in Your Own Game

To use in your own game there are a few prerequisites:

-Install the latest OpenXR Plugin Asset and activate in plugins

-Install the latest OpenXR Tools and activate in plugins

Once you have done that, download the demo code zip and copy the following folders to your OpenXR Tools install:

-addons/follow_bone_3d

-addons/godot-xr-tools/objects/PhysicalKeyboardVR-godot3-5 [the full folder]

-addons/godot-xr-tools/objects/FullPhysicalKeyboard.gd

-addons/godot-xr-tools/objects/FullPhysicalKeyboard.tscn

-addons/godot-xr-tools/interactables/xrt_interactable_area_button.gd

-addons/godot-xr-tools/interactables/xrt_interactable_area_button.tscn

**It's important those folders are in the same location in your project as they are in the demo project.**

Then, activate the follow_bone_3d plugin in Project settings and follow the setup guide here: 
https://github.com/teddybear082/FollowBone3D

This is what gives you the ability to have hands that can physically push objects, the default XR Tools hands do not have this.

Click on the Kinematic Nodes for Left hand and right hand, and add 19 to their collision layers and masks.  Keep the palm Kinematic nodes to just 18, though.

Now just "Add child instance" to your scene the "FullPhysicalKeyboard.tscn" and put it wherever you want keyboard to appear. 

It is a physical object so it will just fall to the ground unless you put it on a table or something.

Of course, to actually type anything you'll still need a Viewport2Dto3D with a LineEdit 2d scene item that requires keyboard input.

If you decide to change collision layers, the following is important:

-The pickablekeyboard collision should be on a layer that your XR-Tools hands pickup function can grab and on a layer they will not fall through the floor

-The keyboard keys (Key.tscn and other special keys .tscn's) static body collision should be on a different collision layer than the pickablekeyboard and areainteractable collision layers

-The keyboard keys' areainteractable collision layers should be on the same layer as the kinematic nodes in your physics hand index fingers but a different layer than your physics palms and other poke-able objects 