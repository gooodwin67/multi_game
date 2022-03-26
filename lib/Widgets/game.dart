import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multy_game/Widgets/levels.dart';
import 'package:multy_game/Widgets/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultyGame extends StatefulWidget {
  final int level;
  List levelsPoints;
  MultyGame({
    Key? key,
    required this.level,
    required this.levelsPoints,
  }) : super(key: key);

  @override
  State<MultyGame> createState() => _MultyGameState();
}

class SettingBlock {
  int res = 0;
  Color color = const Color.fromARGB(235, 62, 136, 248);
  double shadowOpacity = 0.5;
  SettingBlock(
      {required this.res, required this.color, required this.shadowOpacity});
}

class _MultyGameState extends State<MultyGame> {
  Image image = Image.asset('assets/images/pers2.png');
  int levelNum = 0;
  bool canTap = true;
  int num1 = 0;
  int num2 = 0;
  int pointsOnLevel = 0;
  int res = 0;
  int _ex = 10;
  int max = 0;
  int points = 0;
  bool popupEndLevel = false;
  List list = [
    SettingBlock(
        res: 0,
        color: const Color.fromARGB(235, 62, 136, 248),
        shadowOpacity: 0.5),
    SettingBlock(
        res: 0,
        color: const Color.fromARGB(235, 62, 136, 248),
        shadowOpacity: 0.5),
    SettingBlock(
        res: 0,
        color: const Color.fromARGB(235, 62, 136, 248),
        shadowOpacity: 0.5),
  ];
  int _counter = 2;
  Timer _timer = Timer.periodic(Duration(seconds: 1), (timer) {});
  int _secLoader = 0;

  void _startTimer() {
    _counter = 2;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          multypleRes(10);
        }
      });
    });
  }

  void multypleInit() {
    _startTimer();
    image = Image.asset('assets/images/pers2.png');
    list = [
      SettingBlock(
          res: 0,
          color: const Color.fromARGB(235, 62, 136, 248),
          shadowOpacity: 0.5),
      SettingBlock(
          res: 0,
          color: const Color.fromARGB(235, 62, 136, 248),
          shadowOpacity: 0.5),
      SettingBlock(
          res: 0,
          color: const Color.fromARGB(235, 62, 136, 248),
          shadowOpacity: 0.5),
    ];
    if (levelNum < 10) {
      num1 = levelNum;
    } else {
      num1 = 1 + Random().nextInt(9);
    }
    num2 = 1 + Random().nextInt(9);

    res = num1 * num2;
    list[0].res = (1 + Random().nextInt(9)) * (1 + Random().nextInt(9));
    list[1].res = res;
    list[2].res = (1 + Random().nextInt(9)) * (1 + Random().nextInt(9));
    list.shuffle();
  }

  void multypleRes(index) {
    if (_ex > 0) {
      if (canTap) {
        setState(() {
          if (index < 10) {
            _timer.cancel();
            list[index].shadowOpacity = 0.0;
            if (list[index].res == res) {
              list[index].color = const Color.fromARGB(235, 63, 228, 48);
              image = Image.asset('assets/images/pers3.png');
              canTap = false;
              points++;
            } else {
              list[index].color = const Color.fromARGB(235, 228, 60, 48);
              image = Image.asset('assets/images/pers4.png');
              canTap = false;
            }
          } else {
            list[0].shadowOpacity = 0.0;
            list[1].shadowOpacity = 0.0;
            list[2].shadowOpacity = 0.0;
            list[0].color = const Color.fromARGB(235, 228, 60, 48);
            list[1].color = const Color.fromARGB(235, 228, 60, 48);
            list[2].color = const Color.fromARGB(235, 228, 60, 48);
            image = Image.asset('assets/images/pers4.png');
            canTap = false;
          }
        });
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            multypleInit();
            canTap = true;
          });
        });
      }
    } else {
      _timer.cancel();
      canTap = false;
      Future.delayed(const Duration(milliseconds: 0), () {
        setState(() {
          popupEndLevel = true;

          if (points == max - 2 && widget.levelsPoints[widget.level - 1] <= 1) {
            widget.levelsPoints[widget.level - 1] = 1;
          } else if (points == max - 1 &&
              widget.levelsPoints[widget.level - 1] <= 2) {
            widget.levelsPoints[widget.level - 1] = 2;
            pointsOnLevel = 2;
          } else if (points == max &&
              widget.levelsPoints[widget.level - 1] <= 3) {
            widget.levelsPoints[widget.level - 1] = 3;
            pointsOnLevel = 3;
          } else {
            widget.levelsPoints[widget.level - 1] =
                widget.levelsPoints[widget.level - 1];
            pointsOnLevel = 0;
          }

          if (points == max - 2) {
            pointsOnLevel = 1;
          } else if (points == max - 1) {
            pointsOnLevel = 2;
          } else if (points == max) {
            pointsOnLevel = 3;
          } else {
            pointsOnLevel = 0;
          }
          _saveList();
        });
      });
    }
    _ex--;
  }

  @override
  void initState() {
    levelNum = widget.level;
    max = _ex;
    multypleInit();
    super.initState();
  }

  void _saveList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      //levelsPoints[widget.level] = ;
      prefs.setStringList(
          'list', widget.levelsPoints.map((e) => e.toString()).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: const Color(0xffDAE2EB),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Stack(children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ExamNums(num1: num1, num2: num2),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          return multypleRes(0);
                        },
                        splashColor: canTap ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: list[0].color,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(list[0].shadowOpacity),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 7),
                              ),
                            ],
                          ),
                          height: 150,
                          child: Center(
                            child: Text(
                              list[0].res.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          return multypleRes(1);
                        },
                        splashColor: canTap ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: list[1].color,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(list[1].shadowOpacity),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 7),
                              ),
                            ],
                          ),
                          height: 150,
                          child: Center(
                            child: Text(
                              list[1].res.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          return multypleRes(2);
                        },
                        splashColor: canTap ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: list[2].color,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(list[2].shadowOpacity),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 7),
                              ),
                            ],
                          ),
                          height: 150,
                          child: Center(
                            child: Text(
                              list[2].res.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: AnimatedContainer(
                    duration: Duration(
                      seconds: _counter < 2 ? 1 : _secLoader,
                    ),
                    height: canTap ? 2 : 0,
                    width: _counter * 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.green[200]!, Colors.green],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                    child: Text(_counter.toString()),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Stack(children: [
                    Container(
                      width: double.infinity,
                      child: image,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text('ex:$_ex',
                          style: TextStyle(
                              color: Color.fromARGB(255, 100, 100, 100))),
                    )
                  ]),
                ),
              ],
            ),
            popupEndLevel
                ? AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    color: Color.fromARGB(200, 0, 0, 0),
                    child: Center(
                        child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      width: 250,
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            levelNum < 10
                                ? 'Уровень $levelNum'
                                : 'ИТОГОВЫЙ ЭКЗАМЕН',
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: levelNum < 10 ? 30 : 25,
                              color: Color.fromARGB(255, 100, 45, 45),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                pointsOnLevel > 0
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: Color(0xffF9DE09),
                                size: 30,
                              ),
                              Icon(
                                pointsOnLevel > 1
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: Color(0xffF9DE09),
                                size: 30,
                              ),
                              Icon(
                                pointsOnLevel > 2
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: Color(0xffF9DE09),
                                size: 30,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MultyGame(
                                                level: levelNum,
                                                levelsPoints:
                                                    widget.levelsPoints)));
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff6B4EFF)),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Повторить',
                                    style: TextStyle(
                                      fontFamily: 'Georgia',
                                      fontSize: 15,
                                      color: Color(0xffffffff),
                                    ),
                                  )),
                              SizedBox(width: 10),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LevelsWidget(
                                                  level: levelNum,
                                                )));
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff6B4EFF)),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Назад',
                                    style: TextStyle(
                                      fontFamily: 'Georgia',
                                      fontSize: 15,
                                      color: Color(0xffffffff),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )),
                  )
                : Center(),
          ]),
        ),
      ),
    ));
  }
}

class ExamNums extends StatelessWidget {
  const ExamNums({
    Key? key,
    required this.num1,
    required this.num2,
  }) : super(key: key);

  final int num1;
  final int num2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.grey)),
          child: Center(
            child: Text(num1.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 80)),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(' * ', style: TextStyle(fontSize: 80)),
        ),
        Container(
          width: 80,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.grey)),
          child: Center(
            child: Text(num2.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 80)),
          ),
        ),
      ],
    );
  }
}
