import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ball_sort/screens/game_widget/ball_sort_screen.dart';
import 'package:ball_sort/screens/settings/settings_screen.dart';
import 'package:ball_sort/utils/screen_navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
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
              text: "score".tr,
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

                   CustomText(text: "how_to_play".tr,color: whiteColor,),
                   kSizedBoxH10,
                   CustomText(text: "1. ${"content1".tr}",color: whiteColor,),
                   CustomText(text: "2. ${"content2".tr}",color: whiteColor,),
                   CustomText(text: "3. ${"content3".tr}",color: whiteColor,maxLines: 3,),
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
                      image:const DecorationImage(
                        image:  AssetImage('assets/images/game_btn.webp'),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                      child: CustomText(
                        text: "easy".tr,
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
                      title: 'notice'.tr,
                      desc: 'unlock_medium'.tr,

                      btnOkOnPress: () {
                        print('ok');
                      },
                      btnOkText: 'ok'.tr,
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
                        text: "medium".tr,
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
                      title: 'notice'.tr,
                      desc: 'unlock_hard'.tr,

                      btnOkOnPress: () {
                        print('ok');
                      },
                      btnOkText: 'ok'.tr
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
                        text: "hard".tr,
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
