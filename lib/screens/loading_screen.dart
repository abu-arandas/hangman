// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '/screens/score_screen.dart';
import '/utilities/score_db.dart' as score_database;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    queryScores();
  }

  void queryScores() async {
    final database = score_database.openDB();
    var queryResult = await score_database.scores(database);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScoreScreen(query: queryResult),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100,
          ),
        ),
      );
}
