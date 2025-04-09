import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_log_app/src/domain/model/training_session.dart';
import 'package:training_log_app/src/domain/repository/training_session_repository.dart';
import 'dart:developer' as developer;

/// Firestoreを使用したトレーニングセッションリポジトリの実装
class TrainingFirebaseRepository implements TrainingSessionRepository {
  final FirebaseFirestore _firestore;
  final String _collectionPath = 'training_sessions';

  TrainingFirebaseRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> saveTrainingSession(TrainingSession session) async {
    try {
      developer.log('Firestoreにトレーニングセッションを保存開始',
          name: 'TrainingFirebaseRepository');

      final docRef = _firestore.collection(_collectionPath).doc();
      final data = session.toJson();

      developer.log('保存するデータ: $data', name: 'TrainingFirebaseRepository');

      await docRef.set(data);
      developer.log('トレーニングセッションの保存が完了しました',
          name: 'TrainingFirebaseRepository');
    } catch (e, stackTrace) {
      developer.log(
        'トレーニングセッションの保存に失敗しました',
        name: 'TrainingFirebaseRepository',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('トレーニングセッションの保存に失敗しました: $e');
    }
  }

  @override
  Future<TrainingSession?> getTrainingSession(String id) async {
    try {
      final docSnapshot =
          await _firestore.collection(_collectionPath).doc(id).get();
      if (!docSnapshot.exists) {
        return null;
      }
      return TrainingSession.fromJson(docSnapshot.data()!);
    } catch (e) {
      throw Exception('トレーニングセッションの取得に失敗しました: $e');
    }
  }

  @override
  Future<List<TrainingSession>> getAllTrainingSessions() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionPath)
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => TrainingSession.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('トレーニングセッションの一覧取得に失敗しました: $e');
    }
  }

  @override
  Future<void> updateTrainingSession(TrainingSession session) async {
    try {
      final docRef = _firestore.collection(_collectionPath).doc();
      await docRef.update(session.toJson());
    } catch (e) {
      throw Exception('トレーニングセッションの更新に失敗しました: $e');
    }
  }

  @override
  Future<void> deleteTrainingSession(String id) async {
    try {
      await _firestore.collection(_collectionPath).doc(id).delete();
    } catch (e) {
      throw Exception('トレーニングセッションの削除に失敗しました: $e');
    }
  }
}
