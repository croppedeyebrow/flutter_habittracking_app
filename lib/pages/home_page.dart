import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/habit.dart';
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
    var newBox = await Hive.openBox<Habit>('habits');
    if (mounted) {
      setState(() {
        habitsBox = newBox;
      });
    }
  }

  @override
  void dispose() {
    habitsBox?.close();
    super.dispose();
  }

  Widget createHabitTile(Habit habit) {
    return HabitTile(
      habit: habit,
      habitCompleted: habit.completed,
      startTime: habit.startTime.toString(),
      endTime: habit.endTime.toString(),
      category: habit.category,
      onTap: () => toggleHabitCompletion(habit),
      onSetting: () => navigateToSettingHabitPage(habit),
      onDelete: () => deleteHabit(habit),
    );
  }

  void toggleHabitCompletion(Habit habit) {
    setState(() {
      habit.completed = !habit.completed;
      habit.save();
    });
  }

  Future<void> navigateToSettingHabitPage(Habit habit) async {
    final updatedHabit = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingHabitPage(
          habit: habit,
          onUpdateHabit: (updatedHabit) {
            setState(() {
              habitsBox?.put(habit.key, updatedHabit);
            });
          },
        ),
      ),
    );
    if (updatedHabit != null) {
      setState(() {
        habitsBox?.put(habit.key, updatedHabit);
      });
    }
  }

  void deleteHabit(Habit habit) {
    setState(() {
      habit.delete();
    });
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
                return ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    final habit = box.values.elementAt(index);
                    return createHabitTile(habit);
                  },
                  itemExtent: 100.0,
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
