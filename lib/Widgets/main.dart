import 'package:flutter/material.dart';
import 'package:multy_game/Widgets/levels.dart';

List levelsPoints = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Image img = Image.asset('assets/images/pers1.png');
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Изучаем',
                style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 30,
                    color: Color(0xff878787))),
            const SizedBox(height: 10),
            const Text(
              'ТАБЛИЦУ УМНОЖЕНИЯ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 45,
                color: Color(0xff171717),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            img,
            const SizedBox(height: 40),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LevelsWidget(
                              level: 0, levelsPoints: levelsPoints)));
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff6B4EFF)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                child: const Text(
                  'Начать',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 20,
                    color: Color(0xffffffff),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
