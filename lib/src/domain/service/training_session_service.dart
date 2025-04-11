import 'package:training_log_app/src/domain/model/training_session.dart';
import 'package:training_log_app/src/domain/repository/training_session_repository.dart';

/// トレーニングセッションを扱うサービス
class TrainingSessionService {
  final TrainingSessionRepository _repository;

  /// コンストラクタ
  TrainingSessionService(this._repository);

  /// トレーニングセッションを保存する
  Future<void> saveTrainingSession(TrainingSession session) async {
    await _repository.saveTrainingSession(session);
  }

  /// 指定されたkey(userId + yyyyMMdd)に紐づくトレーニングセッションを取得する
  Future<TrainingSession?> getTrainingSession(String key) async {
    return await _repository.getTrainingSession(key);
  }

  /// すべてのトレーニングセッションを取得する
  Future<List<TrainingSession>> getAllTrainingSessions() async {
    return await _repository.getTrainingSessions();
  }

  /// トレーニングセッションを更新する
  Future<void> updateTrainingSession(TrainingSession session) async {
    await _repository.updateTrainingSession(session);
  }

  /// トレーニングセッションを削除する
  Future<void> deleteTrainingSession(String id) async {
    await _repository.deleteTrainingSession(id);
  }

  /// ユーザーIDと日付でトレーニングセッションを取得する
  Future<TrainingSession?> getTrainingSessionByUserIdAndDate(
      String userId, String date) async {
    return await _repository.getTrainingSessionByUserIdAndDate(userId, date);
  }

  Future<List<TrainingSession>> getTrainingSessions() async {
    return await _repository.getTrainingSessions();
  }
}
