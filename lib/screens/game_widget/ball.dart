import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Ball extends StatelessWidget {
  final String imagePath;

  Ball({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath, width: 40.w, height: 40.h);
  }
}