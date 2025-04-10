import 'package:training_log_app/src/domain/model/training_session.dart';

/// トレーニングセッションのリポジトリインターフェース
abstract class TrainingSessionRepository {
  /// トレーニングセッションを保存する
  Future<void> saveTrainingSession(TrainingSession session);

  /// トレーニングセッションを取得する
  Future<TrainingSession?> getTrainingSession(String key);

  /// ユーザーIDと日付でトレーニングセッションを取得する
  Future<TrainingSession?> getTrainingSessionByUserIdAndDate(
      String userId, String date);

  /// すべてのトレーニングセッションを取得する
  Future<List<TrainingSession>> getAllTrainingSessions();

  /// トレーニングセッションを更新する
  Future<void> updateTrainingSession(TrainingSession session);

  /// トレーニングセッションを削除する
  Future<void> deleteTrainingSession(String key);
}
