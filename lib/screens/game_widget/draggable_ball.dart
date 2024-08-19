import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/ball_sort_provider.dart';
import 'ball.dart';

class DraggableBall extends StatelessWidget {
  final String imagePath;
  final int id;

  const DraggableBall({super.key, required this.imagePath, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<BallSortProvider>(
      builder: (context, provider, child) {
        List<String> balls;
        switch (id) {
          case 1:
            balls = provider.tube1Balls;
            break;
          case 2:
            balls = provider.tube2Balls;
            break;
          case 3:
            balls = provider.tube3Balls;
            break;
          case 4:
            balls = provider.tube4Balls;
            break;
          case 5:
            balls = provider.tube5Balls;
            break;
          case 6:
            balls = provider.tube6Balls;
            break;
          case 7:
            balls = provider.tube7Balls;
            break;
          default:
            balls = [];
        }

        bool isTopBall = balls.isNotEmpty && balls.first == imagePath;

        return isTopBall
            ? Draggable<Map<String, dynamic>>(
                data: {'imagePath': imagePath, 'fromTubeID': id},
                feedback: Ball(imagePath: imagePath),
                childWhenDragging: Container(),
                child: Ball(imagePath: imagePath),
              )
            : Ball(imagePath: imagePath);
      },
    );
  }
}