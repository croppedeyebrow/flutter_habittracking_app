import "package:flutter/material.dart";

class HabitTile extends StatefulWidget {
  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onTap,
    required this.onDelete,
    required this.startTime,
    required this.endTime,
  });

  final String habitName;
  final bool habitCompleted;
  final Function(bool?) onTap;
  final VoidCallback onDelete;
  final String startTime; // 시작 시간
  final String endTime;

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
      padding: const EdgeInsets.all(12.0),
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
            //체크박스
            Row(
              children: [
                Checkbox(
                  value: widget.habitCompleted,
                  onChanged: _handleTap,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                //습관 텍스트 기록
                Text(
                  widget.habitName,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      decoration: widget.habitCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                SizedBox(width: 16),
                Column(
                  children: [
                    Text(
                      '시작 시간: ${widget.startTime}', // 시작 시간 표시
                      style: TextStyle(fontSize: 8),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '종료 시간: ${widget.endTime}', // 끝 시간 표시
                      style: TextStyle(fontSize: 8),
                    ),
                  ],
                ),
              ],
            ),
            //습관 제거 버튼.
            IconButton(onPressed: widget.onDelete, icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
