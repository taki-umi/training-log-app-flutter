import 'package:training_log_app/src/domain/model/training_session.dart';

/// トレーニングセッションのリポジトリインターフェース
abstract class TrainingSessionRepository {
  /// トレーニングセッションを保存
  Future<void> saveTrainingSession(TrainingSession session);

  /// トレーニングセッションを取得
  Future<TrainingSession?> getTrainingSession(String id);

  /// トレーニングセッションを更新
  Future<void> updateTrainingSession(TrainingSession session);

  /// トレーニングセッションを削除
  Future<void> deleteTrainingSession(String id);

  /// ユーザーIDと日付でトレーニングセッションを取得
  Future<TrainingSession?> getTrainingSessionByUserIdAndDate(
      String userId, String date);

  /// すべてのトレーニングセッションを取得
  Future<List<TrainingSession>> getTrainingSessions();
}
