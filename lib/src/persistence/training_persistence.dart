import 'package:training_log_app/src/domain/model/training.dart';
import 'package:training_log_app/src/domain/model/training_list.dart';
import 'package:training_log_app/src/domain/repository/training_repository.dart';

class TrainingPersistence implements TrainingRepository {
  @override
  Future<TrainingList> getTrainings() {
    // throw UnimplementedError();
    return Future.value(TrainingList(trainingList: [
      Training(
        id: 1,
        userId: 'USER1',
        title: 'トレーニング1',
        detail: 'トレーニング1の詳細',
      ),
      Training(
        id: 2,
        userId: 'USER1',
        title: 'トレーニング2',
        detail: 'トレーニング2の詳細',
      ),
      Training(
        id: 3,
        userId: 'USER1',
        title: 'トレーニング3',
        detail: 'トレーニング3の詳細',
      ),
    ]));
  }

  @override
  Future<void> addTraining(Training training) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTraining(Training training) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTraining(Training training) {
    throw UnimplementedError();
  }
}
