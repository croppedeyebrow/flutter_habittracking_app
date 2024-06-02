import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

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

  @override
  void dispose() {
    _habitController.dispose();
    super.dispose();
  }

  void _selectDateTime(BuildContext context, bool isStartTime) {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(2100, 12, 31), onConfirm: (date) {
      setState(() {
        if (isStartTime) {
          _startDateTime = date;
        } else {
          _endDateTime = date;
        }
      });
    },
        currentTime: isStartTime
            ? _startDateTime ?? DateTime.now()
            : _endDateTime ?? DateTime.now(),
        locale: LocaleType.ko);
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
      print("습관 추가 완료, 홈 페이지로 돌아갑니다.");
      FocusScope.of(context).unfocus(); // 로그 추가
      Navigator.of(context).pop();
    } else {
      print("습관 추가 실패: 필수 정보가 누락되었습니다."); // 실패 로그 추가
    }
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
    return _categories.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 화면의 어느 곳이든 탭하면 키보드를 숨깁니다.
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                        items: _buildDropdownMenuItems(),
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
      ),
    );
  }
}
