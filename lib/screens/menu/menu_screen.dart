import 'dart:io';

import 'package:ball_sort/screens/game_widget/ball_sort.dart';
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
        // actions: [
        //   IconButton(
        //     iconSize: 40.sp,
        //     icon: Image.asset('assets/images/setting_icon.webp'),
        //     onPressed: () {
        //       //provider.restartGame();
        //     },
        //   ),
        // ],
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
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  context.navigateAndRemoveUntil(const BallSortScreen(), true);
                },
                child: Container(

                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  width: MediaQuery.of(context).size.width,
                  height: 60.h,
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
                  context.navigateAndRemoveUntil(const BallSortScreen(), true);
                },
                child: Container(

                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  width: MediaQuery.of(context).size.width,
                  height: 60.h,
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
                  context.navigateAndRemoveUntil(const BallSortScreen(), true);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  width: MediaQuery.of(context).size.width,
                  height: 60.h,
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
