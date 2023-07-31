import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/actors/player.dart';

late TiledComponent level;

class Level extends World {
  final String levelName;
  final Player player;

  Level({
    required this.levelName,
    required this.player,
  });

  //to load assets
  @override
  FutureOr<void> onLoad() async {
    //make level
    level = await TiledComponent.load("$levelName.tmx", Vector2.all(16));
    add(level); //added the level

    final spownPointsPlayer =
        level.tileMap.getLayer<ObjectGroup>("Spownpoints");
    for (var spownPoint in spownPointsPlayer!.objects) {
      switch (spownPoint.class_) {
        case "Player":
          player.position = Vector2(spownPoint.x, spownPoint.y);
          add(player);
          break;
        default:
      }
    }

    return super.onLoad();
  }
}
