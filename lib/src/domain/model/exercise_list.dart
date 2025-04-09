// エクササイズリストのドメインモデル

import 'package:flutter/foundation.dart';
import 'exercise.dart';
import 'exercise_set.dart';

class ExerciseList extends ChangeNotifier {
  /// エクササイズリスト
  final List<Exercise> exerciseList;

  /// 写真URL
  String _photoUrl;

  // コンストラクタ
  ExerciseList(this._photoUrl, {required this.exerciseList});

  // エクササイズリストの取得
  //
  // リストの要素は変更不可
  List<Exercise> get asList => List.unmodifiable(exerciseList);

  // 写真URL取得
  String get photoUrl => _photoUrl;

  // 写真URL設定
  set photoUrl(String url) {
    _photoUrl = url;
    notifyListeners();
  }

  // エクササイズの追加
  void add(Exercise exercise) {
    exerciseList.add(exercise);
    notifyListeners();
  }

  // エクササイズの削除
  void remove(String exerciseId) {
    exerciseList.removeWhere((exercise) => exercise.id == exerciseId);
    notifyListeners();
  }

  // エクササイズの更新
  void update(Exercise updatedExercise) {
    final index = exerciseList
        .indexWhere((exercise) => exercise.id == updatedExercise.id);
    if (index != -1) {
      exerciseList[index] = updatedExercise;
      notifyListeners();
    }
  }

  // エクササイズの数を取得
  int get length => exerciseList.length;

  // エクササイズが空かどうかを確認
  bool get isEmpty => exerciseList.isEmpty;

  // エクササイズが空でないかどうかを確認
  bool get isNotEmpty => exerciseList.isNotEmpty;

  // TODO: 以下のSampleデータとSampleメソッドは削除予定です
  // リファクタリング完了後に削除してください
  // 元のファイル: exercise_master.dart

  // Sampleデータ: エクササイズのマスターデータ
  static final List<Exercise> sampleExercises = [
    Exercise(
      id: '1',
      name: 'ベンチプレス',
      sets: List.generate(3, (_) => ExerciseSet()),
    ),
    Exercise(
      id: '2',
      name: 'スクワット',
      sets: List.generate(3, (_) => ExerciseSet()),
    ),
    Exercise(
      id: '3',
      name: 'デッドリフト',
      sets: List.generate(3, (_) => ExerciseSet()),
    ),
    Exercise(
      id: '4',
      name: 'ショルダープレス',
      sets: List.generate(3, (_) => ExerciseSet()),
    ),
    Exercise(
      id: '5',
      name: 'ラットプルダウン',
      sets: List.generate(3, (_) => ExerciseSet()),
    ),
  ];

  // Sampleメソッド: エクササイズのマスターデータを取得
  static List<Exercise> getSampleExercises() {
    return List.unmodifiable(sampleExercises);
  }

  // Sampleメソッド: IDでエクササイズを取得
  static Exercise? getSampleExerciseById(String id) {
    try {
      return sampleExercises.firstWhere((exercise) => exercise.id == id);
    } catch (e) {
      return null;
    }
  }
}
