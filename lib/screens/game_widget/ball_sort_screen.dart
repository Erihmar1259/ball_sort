import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ball_sort/constants/color_const.dart';
import 'package:ball_sort/provider/ball_sort_provider.dart';
import 'package:ball_sort/utils/screen_navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants/dimen_const.dart';
import '../../widgets/custom_text.dart';
import '../intro/intro_screen.dart';
import '../settings/settings_screen.dart';
import 'tube.dart';

class BallSortScreen extends StatefulWidget {
  const BallSortScreen({super.key});

  @override
  _BallSortScreenState createState() => _BallSortScreenState();
}

class _BallSortScreenState extends State<BallSortScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BallSortProvider>(context);
    if(provider.isGameOver&&provider.tapDialogCount==0){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AwesomeDialog(
          context: context,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'Game Over',
          desc: 'Time is up!',
          showCloseIcon: true,
          btnOk: GestureDetector(
            onTap: () {
              provider.checkTapDialogCount();
              context.navigateAndRemoveUntil(const IntroScreen(), false);
            },
            child: Image.asset('assets/images/home_btn.webp', width: 30.0, height: 30.0),
          ),
          btnCancel: GestureDetector(
            onTap: () {
              provider.checkTapDialogCount();
              provider.init();
              Navigator.pop(context);
            },
            child: Image.asset('assets/images/replay_icon.webp', width: 30.0, height: 30.0),
          ),
        ).show();});
    }
    return Scaffold(
      backgroundColor: secondaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          iconSize: 40.sp,
          icon: Image.asset('assets/images/back_btn.webp'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "Score",
              color: whiteColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            kSizedBoxW5,
            Icon(Icons.star, color: Colors.yellow[600]),
            kSizedBoxW5,
            CustomText(
              text: provider.bestScore.toString(),
              fontWeight: FontWeight.bold,
              color: whiteColor,
              fontSize: 20.sp,
            ),
          ],
        ),
        actions: [
          IconButton(
            iconSize: 40.sp,
            icon: Image.asset('assets/images/setting_icon.webp'),
            onPressed: () {
              context.navigateAndRemoveUntil(const SettingsScreen(),true);
            },
          ),
        ],
      ),
      body:

           Container(
          padding: EdgeInsets.only(top: 100.h),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.webp'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), // Adjust the opacity here
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    //if (provider.difficultyLevel != 'easy')
                      CustomText(
                        text: "Time: ${provider.remainingTime}s",
                        color: whiteColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 5.w,
                      runSpacing: 10.h,
                      children: <Widget>[
                        Tube(tubeID: 1),
                        Tube(tubeID: 2),
                        Tube(tubeID: 3),
                        Tube(tubeID: 4),
                        Tube(tubeID: 5),
                        if (provider.difficultyLevel != 'easy') Tube(tubeID: 6),
                        if (provider.difficultyLevel == 'hard') Tube(tubeID: 7),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          print("Click restart");
                          provider.init();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.w),
                          width: MediaQuery.of(context).size.width,
                          height: 60.h,
                          decoration: const BoxDecoration(
                            // color: secondaryColor,
                            // borderRadius: BorderRadius.circular(10.r)
                            image: DecorationImage(
                              image: AssetImage('assets/images/game_btn.webp'),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          child: Center(
                              child: CustomText(
                            text: "Restart",
                            fontSize: 16.sp,
                            color: whiteColor,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

      ),
    );
  }
}
