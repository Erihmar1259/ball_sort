import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'draggable_ball.dart';
import 'provider/ball_sort_provider.dart';

class Tube extends StatelessWidget {
  final int tubeID;
  Tube({required this.tubeID});

  @override
  Widget build(BuildContext context) {
    return Consumer<BallSortProvider>(
      builder: (context, provider, child) {
        List<String> balls;
        if (tubeID == 1) {
          balls = provider.tube1Balls;
        } else if (tubeID == 2) {
          balls = provider.tube2Balls;
        } else if (tubeID == 3) {
          balls = provider.tube3Balls;
        } else if (tubeID == 4) {
          balls = provider.tube4Balls;
        } else if (tubeID == 5) {
          balls = provider.tube5Balls;
        } else {
          balls = [];
        }

        return DragTarget<Map<String, dynamic>>(
          onWillAccept: (data) => true,
          onAccept: (data) {
            bool added = provider.addBallToTube(data['imagePath'], tubeID);
            if (!added) {
              // Animate ball back to its original tube
              provider.addBallToTube(data['imagePath'], data['fromTubeID']);
            } else {
              provider.dragComplete(data['imagePath'], data['fromTubeID']);
            }
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              width: 50.w,
              height: 180.h,
              padding: const EdgeInsets.only(bottom: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/tube.webp"), fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: balls.map((imagePath) => DraggableBall(imagePath: imagePath, id: tubeID)).toList(),
              ),
            );
          },
        );
      },
    );
  }
}