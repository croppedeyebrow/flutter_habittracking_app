import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/habit.dart'; // Habit 모델 import
import '../components/habit_tile.dart';
import '../components/habit_drawer.dart';
import '../components/add_habit_page.dart';
import '../components/setting_habit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<Habit>? habitsBox;

  @override
  void initState() {
    super.initState();
    initializeHabitsBox();
  }

  Future<void> initializeHabitsBox() async {
    var box = await Hive.openBox<Habit>('habits');
    setState(() {
      habitsBox = box;
    });
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  Widget createHabitTile(Habit habit) {
    return HabitTile(
      habit: habit,
      habitCompleted: habit.completed,
      startTime: habit.startTime.toString(), // DateTime을 String으로 변환
      endTime: habit.endTime.toString(), // DateTime을 String으로 변환
      category: habit.category,
      onTap: () {
        setState(() {
          habit.completed = !habit.completed;
          habit.save();
        });
      },
      onSetting: () async {
        final updatedHabit = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SettingHabitPage(
                habit: habit,
                onUpdateHabit: (updatedHabit) {
                  setState(() {
                    habitsBox?.put(habit.key, updatedHabit); // 습관 업데이트
                    habit = updatedHabit;
                    habit.save();
                  });
                }),
          ),
        );
        if (updatedHabit != null) {
          setState(() {
            habitsBox?.put(habit.key, updatedHabit); // 습관 업데이트
          });
        }
      },
      onDelete: () {
        setState(() {
          habit.delete();
        });
      },
    );
  }

  void navigateToAddHabitPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddHabitPage(onAddHabit: (Habit newHabit) {
          habitsBox?.add(newHabit);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Day Routine Tracking"),
      ),
      drawer: HabitDrawer(),
      body: habitsBox == null
          ? Center(child: CircularProgressIndicator())
          : ValueListenableBuilder(
              valueListenable: habitsBox!.listenable(),
              builder: (context, Box<Habit> box, _) {
                return ListView(
                  children: box.values
                      .map((habit) => createHabitTile(habit))
                      .toList(),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddHabitPage,
        child: const Icon(Icons.add),
        tooltip: '습관 추가',
      ),
    );
  }
}
