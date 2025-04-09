import 'package:flutter/material.dart';
import 'package:training_log_app/src/domain/model/training_session.dart';
import 'package:training_log_app/src/domain/service/training_session_service.dart';
import 'package:training_log_app/src/persistence/training_firebase_repository.dart';
import 'package:intl/intl.dart';

class TrainingLogList extends StatefulWidget {
  const TrainingLogList({super.key});

  @override
  State<TrainingLogList> createState() => _TrainingLogListState();
}

class _TrainingLogListState extends State<TrainingLogList> {
  final TrainingSessionService _trainingService =
      TrainingSessionService(TrainingFirebaseRepository());

  @override
  Widget build(BuildContext context) {
    return listCard();
  }

  Widget listCard() {
    return FutureBuilder<List<TrainingSession>>(
      future: _trainingService.getAllTrainingSessions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'エラーが発生しました: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        if (snapshot.hasData) {
          final sessions = snapshot.data!;
          if (sessions.isEmpty) {
            return const Center(
              child: Text(
                'トレーニング記録がありません',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child:
                        const Icon(Icons.fitness_center, color: Colors.white),
                  ),
                  title: Text(
                    DateFormat('yyyy/MM/dd').format(session.trainingDate),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    '${session.startTime} - ${session.endTime}',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (session.notes != null &&
                              session.notes!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'メモ: ${session.notes}',
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          const Text(
                            'エクササイズ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...session.exerciseList.asList.map((exercise) {
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                title: Text(exercise.name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: exercise.sets.map((set) {
                                    return Text(
                                      '${set.weight}kg × ${set.reps}回 (休憩: ${set.restInterval}秒)',
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Center(
          child: Text('データを取得できませんでした'),
        );
      },
    );
  }
}
