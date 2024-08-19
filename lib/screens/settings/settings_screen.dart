import 'package:ball_sort/constants/string_const.dart';
import 'package:ball_sort/provider/ball_sort_provider.dart';
import 'package:ball_sort/screens/settings/privacy_policy.dart';
import 'package:ball_sort/utils/screen_navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/color_const.dart';
import '../../constants/dimen_const.dart';
import '../../widgets/custom_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var gameProvider = Provider.of<BallSortProvider>(context);

    return Scaffold(
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
        centerTitle: true,
        title: CustomText(
          text: "Settings",
          color: whiteColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),


      ),
      extendBodyBehindAppBar: true,
      backgroundColor: secondaryColor,
      body: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
              child: CustomText(text: "Your Score",color: whiteColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              width: MediaQuery.of(context).size.width,
              height: 60.h,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "Best Score", color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
                  kSizedBoxW5,
                  CustomText(text: gameProvider.bestScore.toString(), color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
                ],
              ),

            ),
            kSizedBoxH20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
              child: CustomText(text: "Sound Settings",color: whiteColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: (){
                gameProvider.setSoundOnOff();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                width: MediaQuery.of(context).size.width,
                height: 60.h,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Sound",
                      color: whiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    kSizedBoxW5,
                    Image.asset(gameProvider.isMuted?"assets/images/sound_off.webp":"assets/images/sound_btn.webp", width: 40.w, height: 40.h),

                  ],
                ),
              ),
            ),
            kSizedBoxH30,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
              child: CustomText(text: "Others",color: whiteColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                context.navigateAndRemoveUntil(const PrivacyPolicy(), true);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                width: MediaQuery.of(context).size.width,
                height: 60.h,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Privacy Policy", color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
                    kSizedBoxW5,
                    Image.asset('assets/images/privacy.webp', width: 40.w, height: 40.h),
                  ],
                ),

              ),
            ),


            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              width: MediaQuery.of(context).size.width,
              height: 60.h,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "Version", color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
                  kSizedBoxW5,
                  CustomText(text: version, color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}
