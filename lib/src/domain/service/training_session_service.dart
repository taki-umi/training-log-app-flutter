import 'package:training_log_app/src/domain/model/training_session.dart';
import 'package:training_log_app/src/domain/repository/training_session_repository.dart';

/// トレーニングセッションを扱うサービス
class TrainingSessionService {
  final TrainingSessionRepository _repository;

  TrainingSessionService(this._repository);

  /// トレーニングセッションを保存する
  Future<void> saveTrainingSession(TrainingSession session) async {
    await _repository.saveTrainingSession(session);
  }

  /// トレーニングセッションを取得する
  Future<TrainingSession?> getTrainingSession(String id) async {
    return await _repository.getTrainingSession(id);
  }

  /// すべてのトレーニングセッションを取得する
  Future<List<TrainingSession>> getAllTrainingSessions() async {
    return await _repository.getAllTrainingSessions();
  }

  /// トレーニングセッションを更新する
  Future<void> updateTrainingSession(TrainingSession session) async {
    await _repository.updateTrainingSession(session);
  }

  /// トレーニングセッションを削除する
  Future<void> deleteTrainingSession(String id) async {
    await _repository.deleteTrainingSession(id);
  }
}
