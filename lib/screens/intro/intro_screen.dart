import 'dart:io';
import 'package:ball_sort/provider/ball_sort_provider.dart';
import 'package:ball_sort/screens/game_widget/ball_sort.dart';
import 'package:ball_sort/screens/menu/menu_screen.dart';
import 'package:ball_sort/utils/screen_navigation_extension.dart';
import 'package:ball_sort/widgets/custom_circle_loading.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color_const.dart';
import '../../constants/dimen_const.dart';
import '../../utils/global.dart';
import '../../widgets/custom_text.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool isAccepted = false;
  bool isChecked = false;
  int firstTime = 0;
  late WebViewController controller;
  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        firstTime = prefs.getInt('firstTime') ?? 0;

        print("First Time: $firstTime");
        if (firstTime == 0) {
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => Builder(builder: (context) {
                return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return AlertDialog(
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleChildScrollView(
                              child: SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.65,
                                  width: double.infinity,
                                  //width: MediaQuery.of(context).size.width * 0.90,
                                  child: WebViewWidget(
                                      controller: WebViewController()
                                        ..loadHtmlString( Global.policyEn))
                              ),
                            ),
                            // Text(Global.policy, style: TextStyle(fontSize: 12)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  activeColor: Colors.green,
                                  side: BorderSide(
                                    width: 1.5,
                                    color:
                                    isChecked ? Colors.green : Colors.black,
                                  ),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (isChecked) {
                                        isAccepted = true;
                                      } else {
                                        isAccepted = false;
                                      }
                                    });
                                  },
                                ),
                                CustomText(text:"I agree to the privacy policy.",
                                  fontSize: 11.sp,)
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateColor.resolveWith((states) =>
                                  isAccepted
                                      ? secondaryColor
                                      : greyColor)),
                              onPressed: isAccepted
                                  ? () async {
                                SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                prefs.setInt('firstTime', 1);
                                if(context.mounted) Navigator.pop(context);
                              }
                                  : null,
                              child: Text(
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                                "Accept and Continue",
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          }
        }
      } catch (e) {
        print("Error fetching SharedPreferences: $e");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCircleLoading(type: Indicator.ballGridBeat,colors: [Colors.green,Colors.red,Colors.blue,Colors.yellow],width: 120.w,height: 130.h,),
            kSizedBoxH30,
            Consumer<BallSortProvider>(
                builder: (context, provider, _) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Your Best Score is ",
                      color: yellowColor,
                      fontSize: 20.sp,
                      maxLines: 2,
                    ),
                    CustomText(
                      text: "${provider.bestScore}",
                      color: Colors.yellow[900],
                      fontSize: 25.sp,
                      maxLines: 2,
                    ),
                  ],
                )),
            kSizedBoxH30,
            GestureDetector(
              onTap: () {
                context.navigateAndRemoveUntil(const GameMenuScreen(), true);
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
                      text: "Play Now",
                      fontSize: 16.sp,
                      color: whiteColor,
                    )),
              ),
            ),
            kSizedBoxH30,
            GestureDetector(
              onTap: () {
                exit(0);
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
                      text: "Exit",
                      fontSize: 16.sp,
                      color: whiteColor,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
