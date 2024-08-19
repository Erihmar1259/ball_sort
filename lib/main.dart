import 'package:ball_sort/provider/ball_sort_provider.dart';
import 'package:ball_sort/screens/intro/intro_screen.dart';
import 'package:ball_sort/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<BallSortProvider>(
                create: (context) => BallSortProvider()),


          ],
          child:  const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(), // Pass the navigatorKey to SplashScreen
          ),
        );
      },
    );
  }
}