import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TrainingLogCalendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime initialDate;
  final Map<DateTime, List<dynamic>>? events;

  const TrainingLogCalendar({
    super.key,
    required this.onDateSelected,
    required this.initialDate,
    this.events,
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

  List<dynamic> _getEventsForDay(DateTime day) {
    if (widget.events == null) return [];

    final normalizedDate = DateTime(day.year, day.month, day.day);
    return widget.events![normalizedDate] ?? [];
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
        eventLoader: _getEventsForDay,
        calendarStyle: const CalendarStyle(
          markersMaxCount: 1,
          markerDecoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
