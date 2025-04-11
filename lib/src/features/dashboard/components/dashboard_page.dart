import 'package:flutter/material.dart';
import 'package:training_log_app/src/core/components/base_page.dart';
import 'package:training_log_app/src/features/dashboard/components/training_log_list.dart';
import 'package:training_log_app/src/domain/model/training_session.dart';
import 'package:training_log_app/src/domain/service/training_session_service.dart';
import 'package:training_log_app/src/persistence/training_firebase_repository.dart';

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
  Map<DateTime, List<TrainingSession>> _events = {};
  late TrainingSessionService _trainingSessionService;

  @override
  void initState() {
    super.initState();
    _trainingSessionService =
        TrainingSessionService(TrainingFirebaseRepository());
    _loadTrainingSessions();
  }

  Future<void> _loadTrainingSessions() async {
    try {
      final sessions = await _trainingSessionService
          .getTrainingSessions(); // TODO: 対象月で絞った方がいいかも
      final events = <DateTime, List<TrainingSession>>{};

      for (final session in sessions) {
        final date = DateTime(
          session.trainingDate.year,
          session.trainingDate.month,
          session.trainingDate.day,
        );

        if (events[date] == null) {
          events[date] = [];
        }
        events[date]!.add(session);
      }

      setState(() {
        _events = events;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('トレーニングデータの読み込みに失敗しました: $e')),
        );
      }
    }
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  TrainingSession? _getTrainingSessionForDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return _events[normalizedDate]?.first;
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
              events: _events,
            ),
            TrainingLogList(
              selectedDate: _selectedDate,
              trainingSession: _getTrainingSessionForDate(_selectedDate),
            ),
          ],
        ),
      ),
      floatingActionButton: const TrainingAddButton(),
    );
  }
}
