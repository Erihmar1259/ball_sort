import 'package:flutter/material.dart';
import 'dart:math';

class BallSortProvider extends ChangeNotifier {
  List<String> tube1Balls = [];
  List<String> tube2Balls = [];
  List<String> tube3Balls = [];
  List<String> tube4Balls = [];
  List<String> tube5Balls = [];
  int? selectedTubeID;
  String? selectedBallImagePath;
  Offset? selectedBallPosition;

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

  void selectTube(int tubeID, Offset position) {
    if (selectedTubeID == null) {
      selectedTubeID = tubeID;
      selectedBallImagePath = getTubeBalls(tubeID).isNotEmpty ? getTubeBalls(tubeID).first : null;
      selectedBallPosition = position;
    } else {
      moveBall(selectedTubeID!, tubeID);
      selectedTubeID = null;
      selectedBallImagePath = null;
      selectedBallPosition = null;
    }
    notifyListeners();
  }

  void moveBall(int fromTubeID, int toTubeID) {
    List<String> fromTubeBalls = getTubeBalls(fromTubeID);
    List<String> toTubeBalls = getTubeBalls(toTubeID);

    if (fromTubeBalls.isNotEmpty && toTubeBalls.length < 4) {
      String ball = fromTubeBalls.removeAt(0);
      toTubeBalls.insert(0, ball);
      notifyListeners();
    }
  }

  List<String> getTubeBalls(int tubeID) {
    switch (tubeID) {
      case 1:
        return tube1Balls;
      case 2:
        return tube2Balls;
      case 3:
        return tube3Balls;
      case 4:
        return tube4Balls;
      case 5:
        return tube5Balls;
      default:
        return [];
    }
  }
}