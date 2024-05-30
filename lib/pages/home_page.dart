import 'package:flutter/material.dart';

import '../components/habit_drawer.dart';
import '../components/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool habitCompleted = false;

  void checkbocTapped(bool? value) {
    setState(() {
      habitCompleted = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
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
          HabitTile(
            habitName: "아침 : 명상하기",
            habitCompleted: habitCompleted,
            onTap: (value) {
              checkbocTapped(!habitCompleted);
              print("체크박스 클릭");
            },
          ),
        ],
      ),
    );
  }
}
