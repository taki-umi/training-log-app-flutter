import 'package:flutter/foundation.dart';
import 'exercise.dart';

/// エクササイズのCollectionドメインモデル
class ExerciseList extends ChangeNotifier {
  /// エクササイズリスト
  final List<Exercise> exerciseList;

  /// 写真URL
  String _photoUrl;

  /// コンストラクタ
  ///
  /// [photoUrl] 写真URL
  /// [exerciseList] エクササイズリスト, 必須
  ExerciseList(this._photoUrl, {required this.exerciseList});

  /// エクササイズリストの取得
  ///
  /// リストの要素は変更不可
  List<Exercise> get asList => List.unmodifiable(exerciseList);

  /// 写真URL取得
  String get photoUrl => _photoUrl;

  /// 写真URL設定
  set photoUrl(String url) {
    _photoUrl = url;
    notifyListeners();
  }

  /// エクササイズの追加
  void add(Exercise exercise) {
    exerciseList.add(exercise);
    notifyListeners();
  }

  /// エクササイズの削除
  void remove(String exerciseId) {
    exerciseList.removeWhere((exercise) => exercise.id == exerciseId);
    notifyListeners();
  }

  /// エクササイズの更新
  void update(Exercise updatedExercise) {
    final index = exerciseList
        .indexWhere((exercise) => exercise.id == updatedExercise.id);
    if (index != -1) {
      exerciseList[index] = updatedExercise;
      notifyListeners();
    }
  }

  /// エクササイズの数を取得
  int get length => exerciseList.length;

  /// エクササイズが空かどうかを確認
  bool get isEmpty => exerciseList.isEmpty;

  /// エクササイズが空でないかどうかを確認
  bool get isNotEmpty => exerciseList.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      'photoUrl': _photoUrl,
      'exerciseList': exerciseList.map((e) => e.toJson()).toList(),
    };
  }

  factory ExerciseList.fromJson(Map<String, dynamic> json) {
    return ExerciseList(
      json['photoUrl'] as String,
      exerciseList: (json['exerciseList'] as List)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
