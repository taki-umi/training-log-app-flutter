import 'package:flutter/material.dart';
import 'package:training_log_app/src/domain/model/training_session.dart';
import 'package:training_log_app/src/domain/service/training_session_service.dart';
import 'package:training_log_app/src/persistence/training_firebase_repository.dart';
import 'package:intl/intl.dart';

class TrainingLogList extends StatefulWidget {
  final DateTime selectedDate;

  const TrainingLogList({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<TrainingLogList> createState() => _TrainingLogListState();
}

class _TrainingLogListState extends State<TrainingLogList> {
  late final TrainingSessionService _trainingService;
  late Future<TrainingSession?> _sessionFuture;

  @override
  void initState() {
    super.initState();
    _trainingService = TrainingSessionService(TrainingFirebaseRepository());
    _sessionFuture = _getTrainingSession();
  }

  @override
  void didUpdateWidget(TrainingLogList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      _sessionFuture = _getTrainingSession();
    }
  }

  Future<TrainingSession?> _getTrainingSession() {
    return _trainingService.getTrainingSessionByUserIdAndDate(
      'USER01',
      DateFormat('yyyyMMdd').format(widget.selectedDate),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrainingSession?>(
      future: _sessionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
        }

        final session = snapshot.data;
        if (session == null) {
          return const Center(child: Text('トレーニング記録がありません'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: session.exerciseList?.asList?.length ?? 0,
          itemBuilder: (context, index) {
            final exercise = session.exerciseList?.asList?[index];
            if (exercise == null) {
              return const SizedBox.shrink();
            }
            return ListTile(
              title: Text(exercise.name),
              subtitle: Text(exercise.sets.asList
                  .map((set) => '${set.weight}kg x ${set.reps}回')
                  .join(', ')),
              trailing: Text(session.startTime),
            );
          },
        );
      },
    );
  }
}
