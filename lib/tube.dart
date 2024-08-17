import 'package:ball_sort/provider/ball_sort_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'ball.dart';
import 'draggable_ball.dart';

class Tube extends StatelessWidget {
  final int tubeID;
  Tube({required this.tubeID});

  @override
  Widget build(BuildContext context) {
    return Consumer<BallSortProvider>(
      builder: (context, provider, child) {
        List<String> balls = provider.getTubeBalls(tubeID);
        bool isSelected = provider.selectedTubeID == tubeID;
        bool isTopBallVisible = provider.isTopBallVisible[tubeID] ?? true;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTapDown: (details) {
                provider.selectTube(tubeID, details.globalPosition);
              },
              child: Stack(
                children: [
                  Container(
                    width: 50.w,
                    height: 180.h,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: isSelected ? Colors.blue : Colors.grey, width: 2),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: balls.asMap().entries.map((entry) {
                        int index = entry.key;
                        String imagePath = entry.value;
                        bool isTopBall = index == 0;
                        return isTopBall && !isTopBallVisible
                            ? Container(width: 40.w, height: 40.h)
                            : DraggableBall(imagePath: imagePath, id: tubeID);
                      }).toList(),
                    ),
                  ),
                  if (isSelected && balls.isNotEmpty && !isTopBallVisible)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Ball(imagePath: balls.first),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}