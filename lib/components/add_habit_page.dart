import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import '../models/habit.dart'; // Habit 모델 import

class AddHabitPage extends StatefulWidget {
  final Function(Habit) onAddHabit;

  const AddHabitPage({Key? key, required this.onAddHabit}) : super(key: key);

  @override
  _AddHabitPageState createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final TextEditingController _habitController = TextEditingController();
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  String? _selectedCategory;
  List<String> _categories = ['운동', '자기계발', '이너피스', '기타'];
  late Box<Habit> habitsBox;

  @override
  void initState() {
    super.initState();
    habitsBox = Hive.box<Habit>('habits');
  }

  Future<void> _selectDateTime(BuildContext context, bool isStartTime) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = now.isAfter(DateTime(now.year, 12, 31))
        ? DateTime(now.year + 1, 1, 1)
        : now;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year),
      lastDate: DateTime(now.year, 12, 31),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          if (isStartTime) {
            _startDateTime = pickedDateTime;
          } else {
            _endDateTime = pickedDateTime;
          }
        });
      }
    }
  }

  void _addHabit() {
    final String habitName = _habitController.text;
    if (habitName.isNotEmpty &&
        _startDateTime != null &&
        _endDateTime != null) {
      final newHabit = Habit(
        name: habitName,
        startTime: DateFormat('yyyy-MM-dd - kk:mm').format(_startDateTime!),
        endTime: DateFormat('yyyy-MM-dd - kk:mm').format(_endDateTime!),
        category: _selectedCategory,
      );
      habitsBox.add(newHabit);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('새 습관 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _habitController,
              decoration: InputDecoration(
                labelText: '추가할 습관',
                hintText: '추가할 습관을 입력하세요',
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('습관을 시작할 시간'),
              subtitle: Text(_startDateTime != null
                  ? DateFormat('yyyy-MM-dd HH:mm').format(_startDateTime!)
                  : '시작 날짜 및 시간을 선택하세요'),
              onTap: () => _selectDateTime(context, true),
            ),
            ListTile(
              title: Text('습관을 끝낼 시간'),
              subtitle: Text(_endDateTime != null
                  ? DateFormat('yyyy-MM-dd HH:mm').format(_endDateTime!)
                  : '종료 날짜 및 시간을 선택하세요'),
              onTap: () => _selectDateTime(context, false),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text('카테고리:'),
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      hint: Text('선택하세요'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                      items: _categories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      isExpanded: true,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _addHabit,
                  child: Text('추가'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('취소'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
