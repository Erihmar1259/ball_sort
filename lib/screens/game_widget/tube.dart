
import 'package:ball_sort/utils/screen_navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart'; // Import AwesomeDialog package
import '../../provider/ball_sort_provider.dart';
import '../intro/intro_screen.dart';
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

        double tubeHeight = 180.h; // Use appropriate units
        if (provider.difficultyLevel == 'medium') {
          tubeHeight =190.h;
        } else if (provider.difficultyLevel == 'hard') {
          tubeHeight = 210.h;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(

              onTapDown: (details) {
                provider.selectTube(tubeID, details.globalPosition, context);
                if (provider.win == true) {

                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.bottomSlide,
                    title: 'congratulations'.tr,
                    desc: 'you_won'.tr,
                    showCloseIcon: true,
                    btnOk: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) =>const IntroScreen()),
                          (Route<dynamic> route) => false
                        );
                      },
                      child: Image.asset('assets/images/home_btn.webp', width: 30.0, height: 30.0),
                    ),
                    btnCancel: GestureDetector(
                      onTap: () {
                        provider.init();
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/images/replay_icon.webp', width: 30.0, height: 30.0),
                    ),
                  ).show();
                }


              },
              child: Stack(
                children: [
                  Container(
                    width: 50.0,
                    height: tubeHeight,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.pink.withOpacity(0.3),
                      border: Border.all(color: isSelected ? Colors.yellow : Colors.white, width: 2),
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
                            ? SizedBox(width: 40.0, height: 40.0)
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