import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/compunents/collision_block.dart';
import 'package:pixel_adventure/compunents/player.dart';

class Level extends World {
  final String levelName;
  final Player player;
  Level({
    required this.levelName,
    required this.player,
  });
  late TiledComponent level;
  List<CollisionBlock> collisionBlock = [];

  //to load assets
  @override
  FutureOr<void> onLoad() async {
    //make level
    level = await TiledComponent.load("$levelName.tmx", Vector2.all(16));
    add(level); //added the level

    final spownPointsPlayer =
        level.tileMap.getLayer<ObjectGroup>("Spownpoints");

    if (spownPointsPlayer != null) {
      for (var spownPoint in spownPointsPlayer.objects) {
        switch (spownPoint.class_) {
          case "Player":
            player.position = Vector2(spownPoint.x, spownPoint.y);
            add(player);
            break;
          default:
        }
      }
    }

    final collisionPoint = level.tileMap.getLayer<ObjectGroup>("Collision");

    if (collisionPoint != null) {
      for (var collision in collisionPoint.objects) {
        switch (collision.class_) {
          case 'Platform':
            final platform = CollisionBlock(
                position: Vector2(collision.x, collision.y),
                size: Vector2(collision.width, collision.height),
                isPlatform: true);
            collisionBlock.add(platform);
            add(platform);
            break;
          default:
            final block = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
            );
            collisionBlock.add(block);
            add(block);
        }
      }
    }
    player.collisionBlock = collisionBlock;

    return super.onLoad();
  }
}
