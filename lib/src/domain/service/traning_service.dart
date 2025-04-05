// トレーニング記録のService
import 'package:training_log_app/src/domain/model/training_list.dart';
import 'package:training_log_app/src/domain/repository/training_repository.dart';
import 'package:training_log_app/src/persistence/training_persistence.dart';
import '../model/training.dart';

class TrainingService {
  final TrainingRepository repository;

  TrainingService(TrainingPersistence persistence) : repository = persistence;

  // トレーニング記録の取得
  Future<TrainingList> getTrainings() async {
    return await repository.getTrainings();
  }

  // トレーニング記録の追加
  Future<void> addTraining(Training training) async {
    return await repository.addTraining(training);
  }

  // トレーニング記録の更新
  Future<void> updateTraining(Training training) async {
    return await repository.updateTraining(training);
  }

  // トレーニング記録の削除
  Future<void> deleteTraining(Training training) async {
    return await repository.deleteTraining(training);
  }
}
