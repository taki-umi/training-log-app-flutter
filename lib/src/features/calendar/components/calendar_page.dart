import 'package:flutter/material.dart';
import 'package:training_log_app/src/domain/model/training_session.dart';
import 'package:training_log_app/src/domain/service/training_session_service.dart';
import 'package:training_log_app/src/persistence/training_firebase_repository.dart';
import 'package:training_log_app/src/features/training_form/components/training_form_page.dart';
import 'package:training_log_app/src/features/calendar/components/training_detail_modal.dart';
import 'package:training_log_app/src/features/dashboard/components/training_log_calendar.dart';

class CalendarPage extends StatefulWidget {
  final bool showAppBar;

  const CalendarPage({
    super.key,
    this.showAppBar = true,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDay;
  late Map<DateTime, List<TrainingSession>> _events;
  late TrainingSessionService _trainingSessionService;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _events = {};
    _trainingSessionService =
        TrainingSessionService(TrainingFirebaseRepository());
    _loadTrainingSessions();
  }

  Future<void> _loadTrainingSessions() async {
    try {
      final sessions = await _trainingSessionService.getTrainingSessions();
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

      // デバッグ用：読み込まれたデータを確認
      print('読み込まれたトレーニングセッション: ${sessions.length}件');
      print('イベントマップ: ${_events.length}日分');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('トレーニングデータの読み込みに失敗しました: $e')),
        );
      }
    }
  }

  List<TrainingSession> _getEventsForDay(DateTime day) {
    final normalizedDate = DateTime(day.year, day.month, day.day);
    final events = _events[normalizedDate] ?? [];
    print('${normalizedDate.toString()}のイベント: ${events.length}件');
    return events;
  }

  void _onDaySelected(DateTime selectedDay) {
    if (!mounted) return;

    print('日付が選択されました: ${selectedDay.toString()}');

    setState(() {
      _selectedDay = selectedDay;
    });

    // モーダル表示の処理を削除
  }

  @override
  Widget build(BuildContext context) {
    final calendarWidget = Column(
      children: [
        TrainingLogCalendar(
          initialDate: _selectedDay,
          onDateSelected: _onDaySelected,
          events: _events,
        ),
        if (widget.showAppBar) ...[
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                final events = _getEventsForDay(_selectedDay);
                if (events.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('確認'),
                      content: const Text('この日付には既にトレーニング記録が存在します。新規作成しますか？'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('キャンセル'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TrainingFormPage(),
                              ),
                            );
                          },
                          child: const Text('新規作成'),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrainingFormPage(),
                    ),
                  );
                }
              },
              child: const Text('トレーニングを追加'),
            ),
          ),
        ],
      ],
    );

    if (widget.showAppBar) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('トレーニング記録'),
        ),
        body: calendarWidget,
      );
    } else {
      return calendarWidget;
    }
  }
}
