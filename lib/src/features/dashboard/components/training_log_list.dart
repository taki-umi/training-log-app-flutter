import 'package:flutter/material.dart';
import 'package:training_log_app/src/domain/model/training_session.dart';
import 'package:intl/intl.dart';

class TrainingLogList extends StatefulWidget {
  final DateTime selectedDate;
  final TrainingSession? trainingSession;

  const TrainingLogList({
    Key? key,
    required this.selectedDate,
    this.trainingSession,
  }) : super(key: key);

  @override
  State<TrainingLogList> createState() => _TrainingLogListState();
}

class _TrainingLogListState extends State<TrainingLogList> {
  @override
  Widget build(BuildContext context) {
    if (widget.trainingSession == null) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: Text('トレーニング記録がありません')),
      );
    }

    final session = widget.trainingSession!;
    final dateFormat = DateFormat('yyyy年MM月dd日');
    final formattedDate = dateFormat.format(widget.selectedDate);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: session.exerciseList.asList.length,
            itemBuilder: (context, index) {
              final exercise = session.exerciseList.asList[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ...exercise.sets.asList.map((set) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 4.0),
                          child: Text('${set.weight}kg × ${set.reps}回'),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
