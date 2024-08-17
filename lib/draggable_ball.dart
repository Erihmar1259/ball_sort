import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ball.dart';
import 'provider/ball_sort_provider.dart';

class DraggableBall extends StatelessWidget {
  final String imagePath;
  final int id;

  DraggableBall({required this.imagePath, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<BallSortProvider>(
      builder: (context, provider, child) {
        List<String> balls;
        if (id == 1) {
          balls = provider.tube1Balls;
        } else if (id == 2) {
          balls = provider.tube2Balls;
        } else if (id == 3) {
          balls = provider.tube3Balls;
        } else if (id == 4) {
          balls = provider.tube4Balls;
        } else if (id == 5) {
          balls = provider.tube5Balls;
        } else {
          balls = [];
        }
///
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