import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:pixel_adventure/compunents/player.dart';
import 'package:pixel_adventure/compunents/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;
  Player player = Player();
  late JoystickComponent joystick;
  bool showJoystack = false;

  @override
  FutureOr<void> onLoad() async {
    //load all images into assets
    await images.loadAllImages();
    //level-1
    //final world = Level(levelName: "Level-01", characterName: 'Mask Dude');

    //level-2
    final world = Level(levelName: "Level-02", player: player);

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;

    if (showJoystack) {
      addJoyStick();
    }

    addAll([cam, world]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystack) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoyStick() {
    joystick = JoystickComponent(
        knob: SpriteComponent(
          sprite: Sprite(images.fromCache('HUD/Knob.png')),
        ),
        background: SpriteComponent(
            sprite: Sprite(images.fromCache('HUD/Joystick.png'))),
        margin: const EdgeInsets.only(left: 12, bottom: 12));
    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left ||
            JoystickDirection.upLeft ||
            JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right ||
            JoystickDirection.upRight ||
            JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }
}
