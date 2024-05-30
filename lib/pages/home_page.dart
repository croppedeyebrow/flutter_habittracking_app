import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../components/habit_drawer.dart';
import '../components/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> habitTiles = []; // 습관 타일 목록을 관리하는 리스트
  bool habitCompleted = false;

  @override
  void initState() {
    super.initState();
    // 초기 습관 타일 추가
    habitTiles.add(createHabitTile("아침 : 명상하기"));
  }

  Widget createHabitTile(String habitName) {
    return HabitTile(
      habitName: habitName,
      habitCompleted: habitCompleted,
      onTap: (value) {
        setState(() {
          habitCompleted = !habitCompleted;
        });
        print("$habitName 체크박스 클릭");
      },
    );
  }

  void addHabitTile(String habitName) {
    setState(() {
      habitTiles.add(createHabitTile(habitName));
    });
  }

  Future<void> showAddHabitDialog() async {
    TextEditingController habitController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // 다이얼로그 바깥을 터치해도 닫히지 않음
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('새 습관 추가'),
          content: TextField(
            controller: habitController,
            decoration: InputDecoration(hintText: "습관 이름을 입력하세요"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('추가'),
              onPressed: () {
                if (habitController.text.isNotEmpty) {
                  addHabitTile(habitController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 184, 255),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Day Routine Tracking"),
            Spacer(),
            Icon(
              Icons.calendar_month,
              size: 30,
            )
          ],
        ),
      ),
      drawer: HabitDrawer(),
      body: ListView(
        children: [
          ...habitTiles, // 습관 타일 목록을 확장하여 추가
          GestureDetector(
            onTap: showAddHabitDialog, // 아이콘 클릭 시 새 습관 타일 추가
            child: Icon(
              Icons.add_box_rounded,
              size: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
