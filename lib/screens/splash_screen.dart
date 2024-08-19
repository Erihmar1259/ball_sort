import 'package:ball_sort/utils/screen_navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/color_const.dart';
import '../constants/dimen_const.dart';
import '../widgets/custom_circle_loading.dart';
import '../widgets/custom_text.dart';
import 'intro/intro_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),(){
     context.navigateAndRemoveUntil(const IntroScreen(),false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: whiteColor,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg.webp"),fit: BoxFit.cover)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Center(child: ClipRRect(
              //     borderRadius: BorderRadius.circular(20.r),
              //     child: Image.asset("assets/images/splash.webp",width: 200.w,height: 200.h,))),



              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: "Please wait",fontSize: 20.sp,color: whiteColor,),
                  kSizedBoxW10,
                  const CustomCircleLoading()
                ],
              ),
              kSizedBoxH30,
            ],
          ),
        )
    );
  }
}
