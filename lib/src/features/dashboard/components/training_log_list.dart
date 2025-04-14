import 'package:flutter/material.dart';
import 'package:training_log_app/src/domain/model/training_session.dart';
import 'package:intl/intl.dart';
import 'package:training_log_app/src/features/training_form/components/training_form_page.dart';

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
  bool _isExpanded = false;

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
          Text(
            formattedDate,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _getExerciseSummary(session),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    if (_isExpanded) ...[
                      const SizedBox(height: 16),
                      Text('開始時間: ${session.startTime}'),
                      Text('終了時間: ${session.endTime}'),
                      if (session.notes.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text('メモ: ${session.notes}'),
                      ],
                      const SizedBox(height: 16),
                      const Text(
                        'エクササイズ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...session.exerciseList.asList.map((exercise) {
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
                                    padding: const EdgeInsets.only(
                                        left: 16.0, bottom: 4.0),
                                    child:
                                        Text('${set.weight}kg × ${set.reps}回'),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrainingFormPage(
                                  trainingSession: session,
                                  isEditMode: true,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('修正'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getExerciseSummary(TrainingSession session) {
    final exercises = session.exerciseList.asList;
    if (exercises.isEmpty) {
      return 'トレーニング記録なし';
    }

    if (exercises.length == 1) {
      return exercises[0].name;
    } else if (exercises.length == 2) {
      return '${exercises[0].name}, ${exercises[1].name}';
    } else {
      return '${exercises[0].name}, ${exercises[1].name}, その他${exercises.length - 2}種目...';
    }
  }
}
