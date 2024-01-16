import 'package:flutter/material.dart';
import '/screens/home_screen.dart';
import '/utilities/alphabet.dart';
import '/utilities/constants.dart';
import '/utilities/hangman_words.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:math';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '/utilities/score_db.dart' as score_database;
import '/utilities/user_scores.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.hangmanObject});

  final HangmanWords hangmanObject;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final database = score_database.openDB();
  int lives = 5;
  Alphabet englishAlphabet = Alphabet();
  late String word;
  late String hiddenWord;
  List<String> wordList = [];
  List<int> hintLetters = [];
  late List<bool> buttonStatus;
  late bool hintStatus;
  int hangState = 0;
  int wordCount = 0;
  bool finishedGame = false;
  bool resetGame = false;

  void initWords() {
    finishedGame = false;
    resetGame = false;
    hintStatus = true;
    hangState = 0;
    buttonStatus = List.generate(26, (index) => true);
    wordList = [];
    hintLetters = [];
    word = widget.hangmanObject.getWord();
    if (word.isNotEmpty) {
      hiddenWord = widget.hangmanObject.getHiddenWord(word.length);
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }

    for (int i = 0; i < word.length; i++) {
      wordList.add(word[i]);
      hintLetters.add(i);
    }
  }

  void wordPress(int index) {
    if (lives == 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }

    if (finishedGame) {
      setState(() => resetGame = true);
      return;
    }

    bool check = false;
    setState(() {
      for (int i = 0; i < wordList.length; i++) {
        if (wordList[i] == englishAlphabet.alphabet[index]) {
          check = true;
          wordList[i] = '';
          hiddenWord = hiddenWord.replaceFirst(RegExp('_'), word[i], i);
        }
      }
      for (int i = 0; i < wordList.length; i++) {
        if (wordList[i] == '') {
          hintLetters.remove(i);
        }
      }
      if (!check) {
        hangState += 1;
      }

      if (hangState == 6) {
        finishedGame = true;
        lives -= 1;
        if (lives < 1) {
          if (wordCount > 0) {
            Score score = Score(id: 1, scoreDate: DateTime.now().toString(), userScore: wordCount);
            score_database.manipulateDatabase(score, database);
          }
          Alert(style: kGameOverAlertStyle, context: context, title: "Game Over!", desc: "Your score is $wordCount", buttons: [
            DialogButton(
              color: kDialogButtonColor,
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              ),
              child: Icon(MdiIcons.home, size: 30),
            ),
            DialogButton(
              onPressed: () {
                setState(() {
                  widget.hangmanObject.resetWords();
                  englishAlphabet = Alphabet();
                  lives = 5;
                  wordCount = 0;
                  finishedGame = false;
                  resetGame = false;
                  initWords();
                });

                Navigator.pop(context);
              },
              color: kDialogButtonColor,
              child: Icon(MdiIcons.refresh, size: 30),
            ),
          ]).show();
        } else {
          Alert(
            context: context,
            style: kFailedAlertStyle,
            type: AlertType.error,
            title: word,
            buttons: [
              DialogButton(
                radius: BorderRadius.circular(10),
                width: 127,
                color: kDialogButtonColor,
                height: 52,
                child: Icon(MdiIcons.arrowRightThick, size: 30),
                onPressed: () => setState(() {
                  Navigator.pop(context);
                  initWords();
                }),
              ),
            ],
          ).show();
        }
      }

      buttonStatus[index] = false;
      if (hiddenWord == word) {
        finishedGame = true;
        Alert(
          context: context,
          style: kSuccessAlertStyle,
          type: AlertType.success,
          title: word,
          buttons: [
            DialogButton(
              radius: BorderRadius.circular(10),
              width: 127,
              color: kDialogButtonColor,
              height: 52,
              child: Icon(MdiIcons.arrowRightThick, size: 30),
              onPressed: () => setState(() {
                wordCount += 1;
                Navigator.pop(context);
                initWords();
              }),
            )
          ],
        ).show();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    initWords();
  }

  @override
  Widget build(BuildContext context) {
    if (resetGame) {
      setState(() => initWords());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        //
        leading: IconButton(
          onPressed: hintStatus
              ? () {
                  int rand = Random().nextInt(hintLetters.length);
                  wordPress(englishAlphabet.alphabet.indexOf(wordList[hintLetters[rand]]));
                  hintStatus = false;
                }
              : null,
          icon: Icon(MdiIcons.lightbulb),
        ),

        //
        title: Text(
          wordCount == 1 ? "I" : '$wordCount',
          style: kWordCounterTextStyle,
        ),

        //
        actions: List.generate(
          lives,
          (index) => IconButton(
            onPressed: () {},
            icon: Icon(MdiIcons.heart),
          ),
        ),
      ),

      //
      body: Column(
        children: <Widget>[
          const SizedBox(height: 16, width: double.maxFinite),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Image.asset('images/$hangState.png', fit: BoxFit.fill),
                ),
                Expanded(flex: 5, child: Text(hiddenWord, style: kWordTextStyle)),
              ],
            ),
          ),

          // Keyboard
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: List.generate(
              englishAlphabet.alphabet.length,
              (index) => ElevatedButton(
                onPressed: () => wordPress(index),
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.zero,
                  fixedSize: const Size(50, 50),
                  minimumSize: Size.zero,
                ),
                child: Text(
                  englishAlphabet.alphabet[index].toUpperCase(),
                  textAlign: TextAlign.center,
                  style: kWordButtonTextStyle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}
