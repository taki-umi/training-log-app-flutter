import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TrainingLogCalendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime initialDate;

  const TrainingLogCalendar({
    super.key,
    required this.onDateSelected,
    required this.initialDate,
  });

  @override
  State<TrainingLogCalendar> createState() => _TrainingLogCalendarState();
}

class _TrainingLogCalendarState extends State<TrainingLogCalendar> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialDate;
    _selectedDay = widget.initialDate;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      widget.onDateSelected(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TableCalendar(
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: _onDaySelected,
      ),
    );
  }
}
