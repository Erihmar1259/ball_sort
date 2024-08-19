import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../provider/ball_sort_provider.dart';

class Ball extends StatelessWidget {
  final String imagePath;

  Ball({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BallSortProvider>(context);
    double width;
    double height;
    if (provider.difficultyLevel == 'medium') {
      width = 35.w;
      height = 35.h;
    } else if (provider.difficultyLevel == 'hard') {
      width = 32.w;
      height = 32.h;
    } else {
      width = 40.w;
      height = 40.h;
    }
    return Image.asset(imagePath, width: width, height: height);
  }
}