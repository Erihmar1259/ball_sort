import 'package:flutter/material.dart';
import 'dart:math';

class BallSortProvider extends ChangeNotifier {
  List<String> tube1Balls = [];
  List<String> tube2Balls = [];
  List<String> tube3Balls = [];
  List<String> tube4Balls = [];
  List<String> tube5Balls = [];

  BallSortProvider() {
    List<String> ballImages = [
      'assets/images/red.webp',
      'assets/images/blue.webp',
      'assets/images/green.webp',
      'assets/images/yellow.webp',
    ];

    List<String> allBalls = [];
    for (String image in ballImages) {
      allBalls.addAll(List.filled(4, image));
    }

    allBalls.shuffle(Random());

    tube1Balls = allBalls.sublist(0, 4);
    tube2Balls = allBalls.sublist(4, 8);
    tube3Balls = allBalls.sublist(8, 12);
    tube4Balls = allBalls.sublist(12, 16);
    tube5Balls = [];
  }

  void dragComplete(String imagePath, int fromTubeID) {
    if (fromTubeID == 1) {
      tube1Balls.remove(imagePath);
    } else if (fromTubeID == 2) {
      tube2Balls.remove(imagePath);
    } else if (fromTubeID == 3) {
      tube3Balls.remove(imagePath);
    } else if (fromTubeID == 4) {
      tube4Balls.remove(imagePath);
    } else if (fromTubeID == 5) {
      tube5Balls.remove(imagePath);
    }
    notifyListeners();
  }

  bool addBallToTube(String imagePath, int toTubeID) {
    if (toTubeID == 1 && tube1Balls.length < 4) {
      tube1Balls.insert(0, imagePath);
      notifyListeners();
      return true;
    } else if (toTubeID == 2 && tube2Balls.length < 4) {
      tube2Balls.insert(0, imagePath);
      notifyListeners();
      return true;
    } else if (toTubeID == 3 && tube3Balls.length < 4) {
      tube3Balls.insert(0, imagePath);
      notifyListeners();
      return true;
    } else if (toTubeID == 4 && tube4Balls.length < 4) {
      tube4Balls.insert(0, imagePath);
      notifyListeners();
      return true;
    } else if (toTubeID == 5 && tube5Balls.length < 4) {
      tube5Balls.insert(0, imagePath);
      notifyListeners();
      return true;
    }
    return false;
  }
}