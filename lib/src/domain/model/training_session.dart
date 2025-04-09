import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_log_app/src/domain/model/exercise.dart';
import 'dart:developer' as developer;

import 'package:training_log_app/src/domain/model/exercise_list.dart';

/// トレーニングセッションドメインモデル
class TrainingSession {
  /// ユーザーID
  final String userId;

  /// トレーニング日付
  final DateTime trainingDate;

  /// トレーニング開始時間
  final String startTime;

  /// トレーニング終了時間
  final String endTime;

  /// エクササイズリスト
  final ExerciseList exerciseList;

  /// メモ
  final String? notes;

  /// 写真URLリスト
  final String? photoUrl;

  /// コンストラクタ
  ///
  /// param id: トレーニングセッションID 必須
  /// param userId: ユーザーID 必須
  /// param trainingDate: トレーニング日付 必須
  /// param startTime: トレーニング開始時間 必須
  /// param endTime: トレーニング終了時間 必須
  /// param exerciseList: エクササイズリスト 必須
  /// param notes: メモ
  /// param photoUrl: 写真URLリスト
  TrainingSession({
    required this.userId,
    required this.trainingDate,
    required this.startTime,
    required this.endTime,
    required this.exerciseList,
    this.notes,
    this.photoUrl,
  });

  /// トレーニングセッションのキーを取得する
  ///
  /// return トレーニングセッションのキー(userId + trainingDate)
  String get key => '$userId-${trainingDate.toIso8601String()}';

  /// データ永続化のために、JSONに変換する
  /// 主にFirebaseに保存するためのデータ変換のために使用する
  Map<String, dynamic> toJson() {
    try {
      developer.log('TrainingSessionのtoJsonを実行', name: 'TrainingSession');

      final data = {
        'userId': userId,
        'trainingDate': Timestamp.fromDate(trainingDate),
        'startTime': startTime,
        'endTime': endTime,
        'exerciseList': exerciseList.asList.map((e) => e.toJson()).toList(),
        'notes': notes,
        'photoUrl': photoUrl,
      };

      developer.log('変換されたJSON: $data', name: 'TrainingSession');
      return data;
    } catch (e, stackTrace) {
      developer.log(
        'TrainingSessionのtoJsonでエラーが発生しました',
        name: 'TrainingSession',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// JSONからトレーニングセッションを生成する
  /// 主にFirebaseからのデータ取得時にドメインモデルに変換するために使用する
  factory TrainingSession.fromJson(Map<String, dynamic> json) {
    return TrainingSession(
      userId: json['userId'] as String,
      trainingDate: (json['trainingDate'] as Timestamp).toDate(),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      exerciseList: ExerciseList('',
          exerciseList: (json['exerciseList'] as List)
              .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
              .toList()),
      notes: json['notes'] as String,
      photoUrl: json['photoUrl'] as String,
    );
  }

  TrainingSession copyWith({
    String? userId,
    DateTime? trainingDate,
    String? startTime,
    String? endTime,
    List<Exercise>? exercises,
    String? notes,
    String? photoUrl,
  }) {
    return TrainingSession(
      userId: userId ?? this.userId,
      trainingDate: trainingDate ?? this.trainingDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      exerciseList: exercises != null
          ? ExerciseList('', exerciseList: exercises)
          : this.exerciseList,
      notes: notes ?? this.notes,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
