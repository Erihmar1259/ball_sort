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

        return GestureDetector(
          onTapDown: (details) {
            provider.selectTube(tubeID, details.globalPosition);
          },
          child: Stack(
            children: [
              Container(
                width: 50.w,
                height: 230.h,
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
                  children: balls.map((imagePath) {
                    return (isSelected && balls.first.isNotEmpty)?Container():DraggableBall(imagePath: imagePath, id: tubeID);
                  }).toList(),
                ),
              ),
              // if (isSelected && balls.isNotEmpty)
              //   Positioned(
              //     top: 0,
              //     left: 0,
              //     right: 0,
              //     child: Align(
              //       alignment: Alignment.topCenter,
              //       child: isTopBallVisible ? Ball(imagePath: balls.first) : Container(),
              //     ),
              //   ),
            ],
          ),
        );
      },
    );
  }
}