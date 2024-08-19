import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ball_sort/screens/game_widget/ball_sort_screen.dart';
import 'package:ball_sort/screens/settings/settings_screen.dart';
import 'package:ball_sort/utils/screen_navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/color_const.dart';
import '../../constants/dimen_const.dart';
import '../../provider/ball_sort_provider.dart';
import '../../widgets/custom_text.dart';

class GameMenuScreen extends StatelessWidget {
  const GameMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BallSortProvider>(context);
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
              context.navigateAndRemoveUntil(const SettingsScreen(), true);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/bg.webp'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), // Adjust the opacity here
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               Padding(padding:EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   CustomText(text: "How to play?",color: whiteColor,),
                   kSizedBoxH10,
                   CustomText(text: "1. Tap the tube which you want to move the ball.",color: whiteColor,),
                   CustomText(text: "2. Tap the tube where you want to place the ball.",color: whiteColor,),
                   CustomText(text: "3. You can only move the ball to the empty tube or the tube that have free space.",color: whiteColor,maxLines: 3,),
                 ],
               ),
               ),
              GestureDetector(
                onTap: () {
                  provider.setDifficultyLevel("easy");
                  context.navigateAndRemoveUntil(const BallSortScreen(), true);
                },
                child: Container(

                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  width: MediaQuery.of(context).size.width,
                  height: 65.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/images/game_btn.webp'),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                      child: CustomText(
                        text: "Easy",
                        fontSize: 16.sp,
                        color: whiteColor,
                      )),
                ),
              ),
              kSizedBoxH30,
              GestureDetector(
                onTap: () {
                 if(provider.bestScore<10){
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.infoReverse,
                      animType: AnimType.bottomSlide,
                      title: 'Notice!',
                      desc: 'You need to score at least 10 to unlock medium level',
                      btnCancelOnPress: () {
                        print('cancel');
                      },
                      btnOkOnPress: () {
                        print('ok');
                      },
                    ).show();
                  }else{
                    provider.setDifficultyLevel("medium");
                    context.navigateAndRemoveUntil(const BallSortScreen(), true);
                 }
                },
                child: Container(

                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  width: MediaQuery.of(context).size.width,
                  height: 65.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/images/game_btn.webp'),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                      child: CustomText(
                        text: "Medium",
                        fontSize: 16.sp,
                        color: whiteColor,
                      )),
                ),
              ),
              kSizedBoxH30,
              GestureDetector(
                onTap: () {
                 if(provider.bestScore<20){
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.infoReverse,
                      animType: AnimType.bottomSlide,
                      title: 'Notices',
                      desc: 'You need to score at least 20 to unlock hard level',
                      btnCancelOnPress: () {
                        print('cancel');
                      },
                      btnOkOnPress: () {
                        print('ok');
                      },
                    ).show();
                 }else{
                   provider.setDifficultyLevel("hard");
                   context.navigateAndRemoveUntil(const BallSortScreen(), true);
                 }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  width: MediaQuery.of(context).size.width,
                  height: 65.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/images/game_btn.webp'),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                      child: CustomText(
                        text: "Hard",
                        fontSize: 16.sp,
                        color: whiteColor,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
