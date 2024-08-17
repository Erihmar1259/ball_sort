
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  Map<int, bool> isTopBallVisible = {
    1: true,
    2: true,
    3: true,
    4: true,
    5: true
  };
  Map<int, int> tapCount = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
  int bestScore = 0;
  bool win = false;
  BallSortProvider() {
   init();
  }
  init(){
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
    win=false;
    selectedTubeID = null;
    selectedBallImagePath = null;
    selectedBallPosition = null;
    isTopBallVisible = {1: true, 2: true, 3: true, 4: true, 5: true};
    tapCount = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    notifyListeners();

  }

  void selectTube(int tubeID, Offset position, BuildContext context) {
    if (selectedTubeID == null) {
      selectedTubeID = tubeID;
      selectedBallImagePath =
          getTubeBalls(tubeID).isNotEmpty ? getTubeBalls(tubeID).first : null;
      selectedBallPosition = position;
      isTopBallVisible[tubeID] = !isTopBallVisible[tubeID]!;
      tapCount[tubeID] = 1;
    } else if (selectedTubeID == tubeID) {
      tapCount[tubeID] = (tapCount[tubeID] ?? 0) + 1;
      if (tapCount[tubeID] == 2) {
        isTopBallVisible[tubeID] = true;
      } else if (tapCount[tubeID] == 3) {
        isTopBallVisible[tubeID] = true;
        selectedTubeID = null;
        selectedBallImagePath = null;
        selectedBallPosition = null;
        tapCount[tubeID] = 0;
      }
    } else {
      if (selectedTubeID != null) {
        moveBall(selectedTubeID!, tubeID, context);
        tapCount[selectedTubeID!] = 0; // Reset tap count for the previous tube
        selectedTubeID = null;
        selectedBallImagePath = null;
        selectedBallPosition = null;
      }
    }
    notifyListeners();
  }

  void moveBall(int fromTubeID, int toTubeID, BuildContext context) {
    List<String> fromTubeBalls = getTubeBalls(fromTubeID);
    List<String> toTubeBalls = getTubeBalls(toTubeID);

    if (fromTubeBalls.isNotEmpty && toTubeBalls.length < 4) {
      String ball = fromTubeBalls.removeAt(0);
      toTubeBalls.insert(0, ball);
      isTopBallVisible[fromTubeID] = true;

      checkWinCondition(context);
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

  void checkWinCondition(BuildContext context) async {
    int winCount = 0;
    for (int i = 1; i <= 5; i++) {
      List<String> tubeBalls = getTubeBalls(i);
      if (tubeBalls.length == 4 && tubeBalls.toSet().length == 1) {
        winCount++;
      }
    }

    print("It's working! before $winCount");

      if (winCount == 4 ) {
        win = true;
        print("It's working!  $winCount");
        bestScore++;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (bestScore > (prefs.getInt('bestScore') ?? 0)) {
          prefs.setInt('bestScore', bestScore);
        } else {
          bestScore = prefs.getInt('bestScore') ?? 0;
        }

        notifyListeners();
      }

  }

  void restartGame() {
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
    selectedTubeID = null;
    selectedBallImagePath = null;
    selectedBallPosition = null;
    isTopBallVisible = {1: true, 2: true, 3: true, 4: true, 5: true};
    tapCount = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    notifyListeners();
  }
}
