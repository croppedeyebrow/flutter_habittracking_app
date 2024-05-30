import "package:flutter/material.dart";

class HabitTile extends StatelessWidget {
  const HabitTile(
      {super.key,
      required this.habitName,
      required this.habitCompleted,
      required this.onTap});

  final String habitName;

  final bool habitCompleted;
  final Function(bool?) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            //체크박스
            Checkbox(value: habitCompleted, onChanged: onTap),

            Text(
              habitName,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  decoration: habitCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}
