import 'package:hive/hive.dart';

part 'habit.g.dart'; // Hive generator will create this file

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool completed;

  @HiveField(2)
  String startTime;

  @HiveField(3)
  String endTime;

  @HiveField(4)
  String? category;

  Habit(
      {required this.name,
      this.completed = false,
      required this.startTime,
      required this.endTime,
      this.category});
}
