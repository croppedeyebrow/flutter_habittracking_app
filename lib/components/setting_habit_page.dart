import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/habit.dart'; // Habit 모델 import

class SettingHabitPage extends StatefulWidget {
  final Habit habit;
  final Function(Habit) onUpdateHabit;

  const SettingHabitPage(
      {Key? key, required this.habit, required this.onUpdateHabit})
      : super(key: key);

  @override
  _SettingHabitPageState createState() => _SettingHabitPageState();
}

class _SettingHabitPageState extends State<SettingHabitPage> {
  final TextEditingController _habitController = TextEditingController();
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  String? _selectedCategory;
  List<String> _categories = ['운동', '자기계발', '이너피스', '기타'];

  @override
  void initState() {
    super.initState();
    _habitController.text = widget.habit.name;
    _startDateTime =
        DateFormat('yyyy-MM-dd - kk:mm').parse(widget.habit.startTime);
    _endDateTime = DateFormat('yyyy-MM-dd - kk:mm').parse(widget.habit.endTime);
    _selectedCategory = widget.habit.category;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('습관 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _habitController,
              decoration: InputDecoration(
                labelText: '수정하고 싶은 습관',
                hintText: '수정할 습관을 입력하세요',
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('습관을 시작할 시간'),
              subtitle: Text(_startDateTime != null
                  ? DateFormat('yyyy-MM-dd HH:mm').format(_startDateTime!)
                  : '시작 날짜 및 시간을 선택하세요'),
              onTap: () {
                _selectDateTime(context, true);
              },
            ),
            ListTile(
              title: Text('습관을 끝낼 시간'),
              subtitle: Text(_endDateTime != null
                  ? DateFormat('yyyy-MM-dd HH:mm').format(_endDateTime!)
                  : '종료 날짜 및 시간을 선택하세요'),
              onTap: () {
                _selectDateTime(context, false);
              },
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
                  onPressed: () {
                    if (_habitController.text.isNotEmpty &&
                        _startDateTime != null &&
                        _endDateTime != null) {
                      widget.habit.name = _habitController.text;
                      widget.habit.startTime = DateFormat('yyyy-MM-dd - kk:mm')
                          .format(_startDateTime!);
                      widget.habit.endTime = DateFormat('yyyy-MM-dd - kk:mm')
                          .format(_endDateTime!);
                      widget.habit.category = _selectedCategory;
                      widget.habit.save();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('수정'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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
