import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import '../models/habit.dart'; // Habit 모델 import

class HabitTile extends StatefulWidget {
  final Habit habit;
  final bool habitCompleted;
  final String startTime;
  final String endTime;
  final String? category;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onSetting;

  const HabitTile({
    super.key,
    required this.habit,
    required this.onDelete,
    required this.onSetting,
    required this.habitCompleted,
    required this.onTap,
    required this.startTime,
    required this.endTime,
    required this.category,
  });

  @override
  State<HabitTile> createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  bool _showBorder = false;

  void _handleTap(bool? value) {
    setState(() {
      widget.habit.completed = value ?? !widget.habit.completed;
      widget.habit.save();
      _showBorder = !_showBorder;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => widget.onSetting(),
              backgroundColor: Colors.transparent,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(16),
            ),
            SlidableAction(
              onPressed: (context) => widget.onDelete(),
              backgroundColor: Colors.transparent,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(16),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(0, 4))
              ],
              border: _showBorder
                  ? Border.all(color: Colors.blue, width: 2.8)
                  : null),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: widget.habit.completed,
                    onChanged: _handleTap,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  Text(
                    widget.habit.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        decoration: widget.habit.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  SizedBox(width: 12),
                  Column(
                    children: [
                      Text(
                        '시작 시간: ${widget.habit.startTime}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '종료 시간: ${widget.habit.endTime}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                widget.habit.category ?? '카테고리 없음',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
