import 'package:flutter/material.dart';
import 'package:training_log_app/src/core/components/base_page.dart';
import 'package:training_log_app/src/features/dashboard/components/training_log_list.dart';

import 'training_add_button.dart';
import 'training_log_calendar.dart';

// DashboardPage - ダッシュボード画面
//
// ダッシュボード画面の元となるページです。
class DashboardPage extends BasePage {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DashboardPageContent();
  }
}

class _DashboardPageContent extends StatefulWidget {
  const _DashboardPageContent();

  @override
  State<_DashboardPageContent> createState() => _DashboardPageContentState();
}

class _DashboardPageContentState extends State<_DashboardPageContent> {
  DateTime _selectedDate = DateTime.now();

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'トレーニング記録',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TrainingLogCalendar(
              onDateSelected: _onDateSelected,
              initialDate: _selectedDate,
            ),
            TrainingLogList(
              selectedDate: _selectedDate,
            ),
          ],
        ),
      ),
      floatingActionButton: const TrainingAddButton(),
    );
  }
}
