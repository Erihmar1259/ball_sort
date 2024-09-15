import 'package:ball_sort/provider/ball_sort_provider.dart';
import 'package:ball_sort/screens/intro/intro_screen.dart';
import 'package:ball_sort/screens/splash_screen.dart';
import 'package:ball_sort/utils/global.dart';
import 'package:ball_sort/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'languages/enum.dart';
import 'languages/language.dart';

void main() async{
  await LocalStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Global.language = LocalStorage.instance.read(StorageKey.language.name) ??
        Language.zh.name;
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
          child:   GetMaterialApp(
            translations: Languages(),
            locale: Global.language == Language.zh.name
                ? const Locale('zh', 'CN')
                : const Locale('en', 'US'),
            fallbackLocale: const Locale('zh', 'CN'),
            debugShowCheckedModeBanner: false,
            home:const SplashScreen(), // Pass the navigatorKey to SplashScreen
          ),
        );
      },
    );
  }
}