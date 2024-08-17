import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'ball.dart';
import 'draggable_ball.dart';
import 'provider/ball_sort_provider.dart';

class Tube extends StatelessWidget {
  final int tubeID;
  Tube({required this.tubeID});

  @override
  Widget build(BuildContext context) {
    return Consumer<BallSortProvider>(
      builder: (context, provider, child) {
        List<String> balls = provider.getTubeBalls(tubeID);
        bool isSelected = provider.selectedTubeID == tubeID;

        return GestureDetector(
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
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.black,
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: balls.map((imagePath) {
                    return DraggableBall(imagePath: imagePath, id: tubeID);
                  }).toList(),
                ),
              ),
              // if (isSelected && balls.isNotEmpty)
              //   Positioned(
              //     top: -30.h,
              //     left: 0,
              //     right: 0,
              //     child: Align(
              //       alignment: Alignment.topCenter,
              //       child: Ball(imagePath: balls.first),
              //     ),
              //   ),
            ],
          ),
        );
      },
    );
  }
}