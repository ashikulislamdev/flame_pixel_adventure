import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

late TiledComponent level;

class Level extends World {
  //to load assets
  @override
  FutureOr<void> onLoad() async {
    //make level
    level = await TiledComponent.load("Level-01.tmx", Vector2.all(16));
    add(level); //added the level

    return super.onLoad();
  }
}
