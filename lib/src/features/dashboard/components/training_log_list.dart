import 'package:flutter/material.dart';
import 'package:training_log_app/src/domain/model/training_list.dart';
import 'package:training_log_app/src/persistence/training_persistence.dart';

import '../../../domain/service/traning_service.dart';

class TrainingLogList extends StatefulWidget {
  const TrainingLogList({super.key});

  @override
  State<TrainingLogList> createState() => _TrainingLogListState();
}

class _TrainingLogListState extends State<TrainingLogList> {
  final TrainingService _trainingService =
      TrainingService(TrainingPersistence());
  @override
  Widget build(BuildContext context) {
    return listCard();
  }

  Widget listCard() {
    return FutureBuilder(
      future: _trainingService.getTrainings(), // Fetch the data asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while waiting
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Handle errors
        }
        if (snapshot.hasData) {
          final trainings =
              snapshot.data as TrainingList; // Cast the data to a List
          return Container(
            margin: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 8.0), // 外側の余白
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent), // 枠線をなしに設定
              borderRadius: BorderRadius.circular(8.0), // 角丸
              color: Colors.grey[200], // 背景色
            ),
            child: Column(
              children: trainings.asList.map((training) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.photo),
                    title: Text('Training Log ${training.title}'),
                    subtitle: Text('Training Log Detail ${training.detail}'),
                  ),
                );
              }).toList(),
            ),
          );
        }
        return const Text(
            'No data available'); // Handle the case where no data is returned
      },
    );
  }
}
