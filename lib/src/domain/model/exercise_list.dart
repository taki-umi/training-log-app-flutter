// エクササイズリストのドメインモデル

import 'package:flutter/foundation.dart';
import 'exercise.dart';

class ExerciseList extends ChangeNotifier {
  final List<Exercise> exerciseList;
  final List<String> _photoUrls = [];

  // コンストラクタ
  ExerciseList({required this.exerciseList});

  // エクササイズリストの取得
  //
  // リストの要素は変更不可
  List<Exercise> get asList => List.unmodifiable(exerciseList);

  // 写真URLリストの取得
  List<String> get photoUrls => List.unmodifiable(_photoUrls);

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

  // 写真URLの追加
  void addPhotoUrl(String url) {
    _photoUrls.add(url);
    notifyListeners();
  }

  // 写真URLの削除
  void removePhotoUrl(String url) {
    _photoUrls.remove(url);
    notifyListeners();
  }

  // エクササイズの数を取得
  int get length => exerciseList.length;

  // エクササイズが空かどうかを確認
  bool get isEmpty => exerciseList.isEmpty;

  // エクササイズが空でないかどうかを確認
  bool get isNotEmpty => exerciseList.isNotEmpty;
}
