import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddHabitPage extends StatefulWidget {
  final Function(String, DateTime, DateTime) onAddHabit;

  const AddHabitPage({Key? key, required this.onAddHabit}) : super(key: key);

  @override
  _AddHabitPageState createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final TextEditingController _habitController = TextEditingController();
  DateTime? _startDateTime; //시작 시일 선택
  DateTime? _endDateTime; //종료 시일 선택

  Future<void> _selectDateTime(BuildContext context, bool isStartTime) async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
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
                hintText: '습관 이름을 입력하세요',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_habitController.text.isNotEmpty &&
                        _startDateTime != null &&
                        _endDateTime != null) {
                      widget.onAddHabit(_habitController.text, _startDateTime!,
                          _endDateTime!);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('추가'),
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
