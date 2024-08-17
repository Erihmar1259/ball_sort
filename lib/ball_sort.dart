import 'package:ball_sort/provider/ball_sort_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tube.dart';

class BallSortScreen extends StatefulWidget {
  @override
  _BallSortScreenState createState() => _BallSortScreenState();
}

class _BallSortScreenState extends State<BallSortScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ball Sort Puzzle'),
      ),
      body: Consumer<BallSortProvider>(
        builder: (context, provider, _) => Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Tube(tubeID: 1),
              Tube(tubeID: 2),
              Tube(tubeID: 3),
              Tube(tubeID: 4),
              Tube(tubeID: 5),
            ],
          ),
        ),
      ),
    );
  }
}