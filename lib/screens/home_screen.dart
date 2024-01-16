import 'package:flutter/material.dart';

import '/utilities/hangman_words.dart';

import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HangmanWords hangmanWords = HangmanWords();

  @override
  void initState() {
    super.initState();

    hangmanWords.readWords();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'HANGMAN',
                  style: TextStyle(color: Colors.white, fontSize: 64),
                ),
              ),
              Image.asset('images/gallow.png'),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameScreen(hangmanObject: hangmanWords),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.5),
                          ),
                          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        child: const Text('Start'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {}, // TODO
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.5),
                          ),
                          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        child: const Text('Leader'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
