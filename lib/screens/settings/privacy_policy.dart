import 'package:ball_sort/languages/enum.dart';
import 'package:ball_sort/utils/global.dart';
import 'package:ball_sort/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/color_const.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "policy".tr,
          color: whiteColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          iconSize: 40,
          icon: Image.asset('assets/images/back_btn.webp'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: secondaryColor,
      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.webp'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2), // Adjust the opacity here
              BlendMode.dstATop,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(top: 90.h,left: 10.w,right: 10.w),
            child: Text(
            Global.language==Language.zh.name? Global.policyCn:  Global.policy,
              style:  GoogleFonts.audiowide(
                color: whiteColor,
                fontSize: 14.sp,
              ),
            ),
          )
        ),
      ),
    );
  }
}
