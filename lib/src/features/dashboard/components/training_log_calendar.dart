import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TrainingLogCalendar extends StatefulWidget {
  const TrainingLogCalendar({super.key});

  @override
  State<TrainingLogCalendar> createState() => _TrainingLogCalendarState();
}

class _TrainingLogCalendarState extends State<TrainingLogCalendar> {
  // カレンダーが表示される日付
  DateTime _focusedDay = DateTime.now();
  // カレンダー上でマークが表示される日付
  DateTime _currentDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2000, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      currentDay: _currentDay, // マークが表示される日付
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay; // タップした際にマーク位置を更新
          _focusedDay = selectedDay; // タップした際にカレンダーの表示位置を更新
        });
      }),
    );
  }
}
