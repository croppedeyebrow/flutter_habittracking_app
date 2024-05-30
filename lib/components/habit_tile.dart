import "package:flutter/material.dart";

class HabitTile extends StatefulWidget {
  const HabitTile(
      {super.key,
      required this.habitName,
      required this.habitCompleted,
      required this.onTap});

  final String habitName;

  final bool habitCompleted;
  final Function(bool?) onTap;

  @override
  State<HabitTile> createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  bool _showBorder = false;

  void _handleTap(bool? value) {
    widget.onTap(value);
    setState(() {
      _showBorder = !_showBorder;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(24),
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
          children: [
            //체크박스
            Checkbox(
              value: widget.habitCompleted,
              onChanged: _handleTap,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),

            Text(
              widget.habitName,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  decoration: widget.habitCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}
