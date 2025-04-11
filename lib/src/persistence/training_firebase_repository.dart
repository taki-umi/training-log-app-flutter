import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_log_app/src/domain/model/training_session.dart';
import 'package:training_log_app/src/domain/repository/training_session_repository.dart';
import 'dart:developer' as developer;

/// Firestoreを使用したトレーニングセッションリポジトリの実装
class TrainingFirebaseRepository implements TrainingSessionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'training_sessions';

  @override
  Future<void> saveTrainingSession(TrainingSession session) async {
    final querySnapshot = await _firestore
        .collection(_collection)
        .where('userId', isEqualTo: session.userId)
        .where('trainingDate', isEqualTo: session.trainingDate)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.update(session.toJson());
    } else {
      await _firestore
          .collection(_collection)
          .doc(session.key)
          .set(session.toJson());
    }
  }

  @override
  Future<TrainingSession?> getTrainingSession(String id) async {
    final doc = await _firestore.collection(_collection).doc(id).get();
    if (!doc.exists) return null;
    return TrainingSession.fromJson(doc.data()!);
  }

  @override
  Future<void> updateTrainingSession(TrainingSession session) async {
    final querySnapshot = await _firestore
        .collection(_collection)
        .where('userId', isEqualTo: session.userId)
        .where('trainingDate', isEqualTo: session.trainingDate)
        .get();

    if (querySnapshot.docs.isEmpty) return;
    await querySnapshot.docs.first.reference.update(session.toJson());
  }

  @override
  Future<void> deleteTrainingSession(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }

  @override
  Future<TrainingSession?> getTrainingSessionByUserIdAndDate(
      String userId, String date) async {
    final startOfDay = DateTime.parse(date);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final querySnapshot = await _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .where('trainingDate', isGreaterThanOrEqualTo: startOfDay)
        .where('trainingDate', isLessThan: endOfDay)
        .get();

    if (querySnapshot.docs.isEmpty) return null;
    return TrainingSession.fromJson(querySnapshot.docs.first.data());
  }

  @override
  Future<List<TrainingSession>> getTrainingSessions() async {
    final querySnapshot = await _firestore.collection(_collection).get();
    return querySnapshot.docs
        .map((doc) => TrainingSession.fromJson(doc.data()))
        .toList();
  }
}
