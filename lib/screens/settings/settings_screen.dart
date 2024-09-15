import 'package:ball_sort/constants/string_const.dart';
import 'package:ball_sort/provider/ball_sort_provider.dart';
import 'package:ball_sort/screens/settings/privacy_policy.dart';
import 'package:ball_sort/utils/screen_navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:provider/provider.dart';

import '../../constants/color_const.dart';
import '../../constants/dimen_const.dart';
import '../../widgets/custom_text.dart';
import 'change_language_screen.dart';

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
          text: "settings".tr,
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
              child: CustomText(text: "score_board".tr,color: whiteColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
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
                  CustomText(text: "best_score".tr, color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
                  kSizedBoxW5,
                  CustomText(text: gameProvider.bestScore.toString(), color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
                ],
              ),

            ),
            kSizedBoxH20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
              child: CustomText(text: "language_settings".tr,color: whiteColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: (){
                context.navigateAndRemoveUntil(const ChangeLanguageScreen(), true);
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
                      text: "change_language".tr,
                      color: whiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    kSizedBoxW5,
                   Icon(Icons.language, color: whiteColor, size: 40.w),

                  ],
                ),
              ),
            ),
            kSizedBoxH20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
              child: CustomText(text: "sound_settings".tr,color: whiteColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
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
                      text: "sound".tr,
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
              child: CustomText(text: "general".tr,color: whiteColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
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
                    CustomText(text: "policy".tr, color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                  CustomText(text: "version".tr, color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
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
