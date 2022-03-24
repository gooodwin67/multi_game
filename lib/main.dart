import 'package:flutter/material.dart';
import 'package:multy_game/Widgets/game.dart';
import 'package:multy_game/Widgets/levels.dart';
import 'package:multy_game/Widgets/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: MainWidget(),
          backgroundColor: Color(0xffDAE2EB),
        ),
        routes: {
          //'/game': (context) => MultyGame(),
          //'/levels': (context) => LevelsWidget(),
        });
  }
}
