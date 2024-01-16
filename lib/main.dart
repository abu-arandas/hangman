import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          tooltipTheme: TooltipThemeData(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              letterSpacing: 1,
              color: Colors.white,
            ),
          ),
          scaffoldBackgroundColor: const Color(0xFF421b9b),
          textTheme: Theme.of(context).textTheme.apply(fontFamily: 'PatrickHand'),
        ),
        home: const HomeScreen(),
      );
}
