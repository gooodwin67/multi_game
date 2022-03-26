import 'package:flutter/material.dart';
import 'package:multy_game/Widgets/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelsWidget extends StatefulWidget {
  final int level;
  const LevelsWidget({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  State<LevelsWidget> createState() => _LevelsWidgetState();
}

class _LevelsWidgetState extends State<LevelsWidget> {
  //List levelsPoints = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> levelsPoints = [];
  List<int> levelsPointsInt = [];
  List<String> levelsPointsStr = [];

  @override
  void initState() {
    /*if (widget.level > 0) {
      if (widget.points == 2) {
        widget.levelsPoints[widget.level - 1] = 1;
      } else if (widget.points == 3) {
        widget.levelsPoints[widget.level - 1] = 2;
      } else if (widget.points == 4) {
        widget.levelsPoints[widget.level - 1] = 3;
      }
    }*/
    super.initState();
    _loadList();
    _saveList();
  }

  void _loadList() async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    levelsPointsStr = prefs.getStringList('list') ??
        ['0', '0', '0', '0', '0', '0', '0', '0', '0', '0'];

    setState(() {
      levelsPoints = levelsPointsStr.map((e) => int.parse(e)).toList();
    });
  }

  void _saveList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList(
          'list', levelsPoints.map((e) => e.toString()).toList());
    });
  }

  void _clearList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.clear();
      _loadList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffDAE2EB),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Выберите уровень',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 45,
                      color: Color(0xff171717),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 13,
                    shrinkWrap: true,
                    children: [
                      LevelBtn(level: 1, levelsPoints: levelsPoints),
                      LevelBtn(level: 2, levelsPoints: levelsPoints),
                      LevelBtn(level: 3, levelsPoints: levelsPoints),
                      LevelBtn(level: 4, levelsPoints: levelsPoints),
                      LevelBtn(level: 5, levelsPoints: levelsPoints),
                      LevelBtn(level: 6, levelsPoints: levelsPoints),
                      LevelBtn(level: 7, levelsPoints: levelsPoints),
                      LevelBtn(level: 8, levelsPoints: levelsPoints),
                      LevelBtn(level: 9, levelsPoints: levelsPoints),
                    ],
                  ),
                  SizedBox(height: 13),
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: LevelBtn(level: 10, levelsPoints: levelsPoints),
                  ),
                  SizedBox(height: 13),
                  TextButton(
                      onPressed: _clearList, child: Text('Удалить результаты'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LevelBtn extends StatelessWidget {
  int level;
  List levelsPoints;
  LevelBtn({
    Key? key,
    required this.level,
    required this.levelsPoints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.black,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MultyGame(level: level, levelsPoints: levelsPoints)));
          },
          child: Container(
            decoration: BoxDecoration(
                color: levelsPoints[level - 1] > 0
                    ? Color.fromARGB(243, 56, 148, 56)
                    : Color(0xf37083E7),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  level < 10 ? '$level' : 'ИТОГОВЫЙ ЭКЗАМЕН',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: level < 10 ? 40 : 28,
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      levelsPoints[level - 1] > 0
                          ? Icons.star
                          : Icons.star_border_outlined,
                      color: Color(0xffF9DE09),
                      size: 30,
                    ),
                    Icon(
                      levelsPoints[level - 1] > 1
                          ? Icons.star
                          : Icons.star_border_outlined,
                      color: Color(0xffF9DE09),
                      size: 30,
                    ),
                    Icon(
                      levelsPoints[level - 1] > 2
                          ? Icons.star
                          : Icons.star_border_outlined,
                      color: Color(0xffF9DE09),
                      size: 30,
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
