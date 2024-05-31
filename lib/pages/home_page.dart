import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_habittracking_app/components/add_habit_page.dart';
import 'package:intl/intl.dart';

import '../components/habit_drawer.dart';
import '../components/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> habits = []; // 습관 타일 목록을 관리하는 리스트
  bool habitCompleted = false;

  @override
  void initState() {
    super.initState();
    // 초기 습관 타일 추가
    habits.add({
      "name": "Ex)아침 : 명상하기",
      "completed": false,
    });
  }

  Widget createHabitTile(Map<String, dynamic> habit) {
    // 습관 타일 생성 함수
    return HabitTile(
      habitName: habit['name'],
      habitCompleted: habit['completed'],
      startTime: habit['startTime'] ?? '__', // null 체크
      endTime: habit['endTime'] ?? '__', // null 체크
      category: habit['category'] ?? '__', // null 체크
      onTap: (value) {
        setState(() {
          habit['completed'] = !habit['completed']; // 습관 완료 상태 토글
        });
        print("${habit['name']} 체크박스 클릭"); // 콘솔에 로그 출력
      },
      onDelete: () {
        setState(() {
          habits.remove(habit);
        });
        print("습관삭제");
      },
    );
  }

  void addHabitTile(String habitName, DateTime startTime, DateTime endTime,
      String? category) {
    // 새 습관 타일 추가 함수
    setState(() {
      habits.add({
        "name": habitName,
        "completed": false,
        "startTime": DateFormat('yyyy-MM-dd - kk:mm').format(startTime),
        "endTime": DateFormat('yyyy-MM-dd - kk:mm').format(endTime),
        "category": category,
      }); // 새 습관을 리스트에 추가
    });
  }

  void navigateToAddHabitPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddHabitPage(onAddHabit: addHabitTile),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 위젯 빌드 함수
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 184, 255),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Day Routine Tracking"),
            Spacer(),
            Icon(
              Icons.share,
              size: 30,
            )
          ],
        ),
      ),
      drawer: HabitDrawer(), // 습관 관리용 드로어 위젯
      body: ListView(
          children: habits.map((habit) => createHabitTile(habit)).toList()),
      floatingActionButton: FloatingActionButton(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Color.fromARGB(255, 139, 184, 255),
        onPressed: navigateToAddHabitPage,
        child: Icon(Icons.add),
        tooltip: '습관 추가',
      ),
    );
  }
}
