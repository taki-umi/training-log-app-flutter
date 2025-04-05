// トレーニング記録のRepository

import 'package:training_log_app/src/domain/model/training_list.dart';

import '../model/training.dart';

abstract class TrainingRepository {
  Future<TrainingList> getTrainings();
  Future<void> addTraining(Training training);
  Future<void> updateTraining(Training training);
  Future<void> deleteTraining(Training training);
}
