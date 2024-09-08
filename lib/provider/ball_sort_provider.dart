import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ball_sort/utils/screen_navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import '../screens/intro/intro_screen.dart';

class BallSortProvider extends ChangeNotifier {
  List<String> tube1Balls = [];
  List<String> tube2Balls = [];
  List<String> tube3Balls = [];
  List<String> tube4Balls = [];
  List<String> tube5Balls = [];
  List<String> tube6Balls = [];
  List<String> tube7Balls = [];
  int? selectedTubeID;
  String? selectedBallImagePath;
  Offset? selectedBallPosition;
  final player = AudioPlayer();
  final player1 = AudioPlayer();
  bool isMuted = true;
  Map<int, bool> isTopBallVisible = {
    1: true,
    2: true,
    3: true,
    4: true,
    5: true,
    6: true,
    7: true,
  };
  Map<int, int> tapCount = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0};
  int bestScore = 0;
  bool win = false;
  bool isGameOver = false;
  int tapDialogCount = 0;
  String difficultyLevel = 'easy';
  int remainingTime = 60;
  Timer? _timer;
  bool sound = false;

  BallSortProvider() {
    updateScore();
    init();
  }
  init() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    isMuted = sh.getBool("isMuted") ?? true;
    tapDialogCount = 0;
    isGameOver = false;
    playSound();
    // Check if the user can play the selected difficulty level
    if (difficultyLevel == 'medium' && bestScore < 10) {
      difficultyLevel = 'easy';
      // Optionally, notify the user that they cannot play medium level
    } else if (difficultyLevel == 'hard' && bestScore < 20) {
      difficultyLevel = 'easy';
      // Optionally, notify the user that they cannot play hard level
    }
    List<String> easyBallImages = [
      'assets/images/red.webp',
      'assets/images/blue.webp',
      'assets/images/green.webp',
      'assets/images/yellow.webp',
    ];
    List<String> mediumBallImages = [
      'assets/images/red.webp',
      'assets/images/blue.webp',
      'assets/images/green.webp',
      'assets/images/yellow.webp',
      'assets/images/purple.webp',
    ];
    List<String> hardBallImages = [
      'assets/images/red.webp',
      'assets/images/blue.webp',
      'assets/images/green.webp',
      'assets/images/yellow.webp',
      'assets/images/purple.webp',
      'assets/images/orange.webp',
    ];

    List<String> allBalls = [];

    int numberOfTubes;
    int ballsPerTube;
    if (difficultyLevel == 'easy') {
      for (String image in easyBallImages) {
        allBalls.addAll(List.filled(4, image));
      }
      allBalls.shuffle(Random());
      numberOfTubes = 5;
      ballsPerTube = 4;
    } else if (difficultyLevel == 'medium') {
      for (String image in mediumBallImages) {
        allBalls.addAll(List.filled(5, image));
      }
      allBalls.shuffle(Random());
      numberOfTubes = 6;
      ballsPerTube = 5;
    } else if (difficultyLevel == 'hard') {
      for (String image in hardBallImages) {
        allBalls.addAll(List.filled(6, image));
      }
      allBalls.shuffle(Random());
      numberOfTubes = 7;
      ballsPerTube = 6;
    } else {
      for (String image in easyBallImages) {
        allBalls.addAll(List.filled(4, image));
      }
      allBalls.shuffle(Random());
      numberOfTubes = 5; // Default to easy if difficulty level is unknown
      ballsPerTube = 4;
    }

    List<List<String>> tubes = List.generate(numberOfTubes, (_) => []);
    for (int i = 0; i < numberOfTubes - 1; i++) {
      int start = i * ballsPerTube;
      int end = start + ballsPerTube;
      if (end <= allBalls.length) {
        tubes[i] = allBalls.sublist(start, end);
      }
    }

    tube1Balls = tubes[0];
    tube2Balls = tubes[1];
    tube3Balls = tubes[2];
    tube4Balls = tubes[3];
    tube5Balls = numberOfTubes > 4 ? tubes[4] : [];
    tube6Balls = numberOfTubes > 5 ? tubes[5] : [];
    tube7Balls = [];
    win = false;
    selectedTubeID = null;
    selectedBallImagePath = null;
    selectedBallPosition = null;
    isTopBallVisible = {
      1: true,
      2: true,
      3: true,
      4: true,
      5: true,
      6: true,
      7: true
    };
    tapCount = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0};
    // if (difficultyLevel == 'medium' || difficultyLevel == 'hard') {
    startTimer();
    // }
    notifyListeners();
  }

  void playWinSound() async {
    player1.play(
      AssetSource('audio/yay.mp3'),
    );
    player1.setVolume(1.0);
    Future.delayed(const Duration(seconds: 5)).then((value) => player1.stop());
  }

  void playLoseSound() async {
    player1.play(
      AssetSource('audio/defeat.mp3'),
    );
    player1.setVolume(1.0);
    Future.delayed(const Duration(seconds: 5)).then((value) => player1.stop());
  }

  void playSound() async {
    await player.setReleaseMode(ReleaseMode.loop);
    await player.play(
      AssetSource('audio/MainTheme.mp3'),
    );

    if (isMuted) {
      player.setVolume(0.0);
    } else {
      player.setVolume(1.0);
    }
    notifyListeners();
  }

  void setSoundOnOff() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    isMuted = !isMuted;
    if (isMuted) {
      player.setVolume(0.0);
    } else {
      player.setVolume(1.0);
    }
    sh.setBool("isMuted", isMuted);
    notifyListeners();
  }

  void checkTapDialogCount() {
    tapDialogCount++;
    notifyListeners();
  }

  void startTimer() {
    if (difficultyLevel == 'easy') {
      remainingTime = 45;
    } else if (difficultyLevel == 'medium') {
      remainingTime = 90;
    } else if (difficultyLevel == 'hard') {
      remainingTime = 120;
    } else {
      remainingTime = 60; // Default to for other levels
    }

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        notifyListeners();
      } else {
        print("Why");
        timer.cancel();
        isGameOver = true;
        if (isGameOver) {
          playLoseSound();
        }
        notifyListeners();
      }
    });
  }

  void setDifficultyLevel(String level) {
    difficultyLevel = level;
    notifyListeners();
    init();
  }

  // void selectTube(int tubeID, Offset position, BuildContext context) {
  //   if (selectedTubeID == null) {
  //     selectedTubeID = tubeID;
  //     selectedBallImagePath =
  //         getTubeBalls(tubeID).isNotEmpty ? getTubeBalls(tubeID).first : null;
  //     selectedBallPosition = position;
  //     isTopBallVisible[tubeID] = !isTopBallVisible[tubeID]!;
  //     tapCount[tubeID] = 1;
  //   } else if (selectedTubeID == tubeID) {
  //     tapCount[tubeID] = (tapCount[tubeID] ?? 0) + 1;
  //     if (tapCount[tubeID] == 2) {
  //       isTopBallVisible[tubeID] = true;
  //       selectedTubeID = null;
  //       selectedBallImagePath = null;
  //       selectedBallPosition = null;
  //       tapCount[tubeID] = 0;
  //     } else if (tapCount[tubeID] == 3) {
  //       isTopBallVisible[tubeID] = true;
  //       selectedTubeID = null;
  //       selectedBallImagePath = null;
  //       selectedBallPosition = null;
  //       tapCount[tubeID] = 0;
  //     }
  //   } else {
  //     if (selectedTubeID != null) {
  //       moveBall(selectedTubeID!, tubeID, context);
  //       tapCount[selectedTubeID!] = 0; // Reset tap count for the previous tube
  //       selectedTubeID = null;
  //        selectedBallImagePath = null;
  //        selectedBallPosition = null;
  //     }
  //   }
  //   notifyListeners();
  // }
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
        selectedTubeID = null;
        selectedBallImagePath = null;
        selectedBallPosition = null;
        tapCount[tubeID] = 0;
      } else if (tapCount[tubeID] == 3) {
        isTopBallVisible[tubeID] = true;
        selectedTubeID = null;
        selectedBallImagePath = null;
        selectedBallPosition = null;
        tapCount[tubeID] = 0;
      }
    } else {
      if (selectedTubeID != null) {
        List<String> toTubeBalls = getTubeBalls(tubeID);
        int maxBallsPerTube;
        if (difficultyLevel == 'easy') {
          maxBallsPerTube = 4;
        } else if (difficultyLevel == 'medium') {
          maxBallsPerTube = 5;
        } else if (difficultyLevel == 'hard') {
          maxBallsPerTube = 6;
        } else {
          maxBallsPerTube = 4; // Default to easy if difficulty level is unknown
        }

        if (toTubeBalls.length < maxBallsPerTube) {
          moveBall(selectedTubeID!, tubeID, context);
          tapCount[selectedTubeID!] =
              0; // Reset tap count for the previous tube
          selectedTubeID = null;
          selectedBallImagePath = null;
          selectedBallPosition = null;
        } else {
          // Notify the user that the destination tube is full
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('The destination tube is full!'),
            ),
          );
          // Restore the ball to its original place with animation
          Future.delayed(Duration(milliseconds: 100), () {
            //tapCount[selectedTubeID!] = 0;
            //selectedTubeID = null;
            //selectedBallImagePath = null;
            //selectedBallPosition = null;
            notifyListeners();
          });
        }
      }
    }
    notifyListeners();
  }

  void moveBall(int fromTubeID, int toTubeID, BuildContext context) {
    List<String> fromTubeBalls = getTubeBalls(fromTubeID);
    List<String> toTubeBalls = getTubeBalls(toTubeID);

    int maxBallsPerTube;
    if (difficultyLevel == 'easy') {
      maxBallsPerTube = 4;
    } else if (difficultyLevel == 'medium') {
      maxBallsPerTube = 5;
    } else if (difficultyLevel == 'hard') {
      maxBallsPerTube = 6;
    } else {
      maxBallsPerTube = 4; // Default to easy if difficulty level is unknown
    }
    if (fromTubeBalls.isNotEmpty) {
      if (toTubeBalls.length < maxBallsPerTube) {
        String ball = fromTubeBalls.removeAt(0);
        toTubeBalls.insert(0, ball);
        isTopBallVisible[fromTubeID] = true;

        checkWinCondition(context);
        notifyListeners();
      } else {
        // Restore the ball to its original place with animation
        Future.delayed(Duration(milliseconds: 300), () {
          notifyListeners();
        });
      }
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
      case 6:
        return tube6Balls;
      case 7:
        return tube7Balls;
      default:
        return [];
    }
  }

  void checkWinCondition(BuildContext context) async {
    int winCount = 0;
    int numberOfTubes = difficultyLevel == 'easy'
        ? 5
        : difficultyLevel == 'medium'
            ? 6
            : 7;
    int ballsPerTube = difficultyLevel == 'easy'
        ? 4
        : difficultyLevel == 'medium'
            ? 5
            : 6;

    for (int i = 1; i <= numberOfTubes; i++) {
      List<String> tubeBalls = getTubeBalls(i);
      if (tubeBalls.length == ballsPerTube && tubeBalls.toSet().length == 1) {
        winCount++;
      }
    }

    if (winCount == numberOfTubes - 1) {
      win = true;
      isGameOver = false;
      bestScore++;
      _timer?.cancel();
      playWinSound();
      updateScore();
      notifyListeners();
    }
  }

  void updateScore() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // int? score = prefs.getInt('bestScore');
    // if (score == null || bestScore > score) {
    //   prefs.setInt('bestScore', bestScore);
    // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (bestScore > (prefs.getInt('bestScore') ?? 0)) {
      prefs.setInt('bestScore', bestScore);
    } else {
      bestScore = prefs.getInt('bestScore') ?? 0;
    }
    notifyListeners();
  }

  void restartGame() {
    init();
  }

  @override
  void dispose() {
    isGameOver = false;
    win = false;
    _timer?.cancel();
    player.dispose();
    player1.dispose();
    super.dispose();
  }
}
