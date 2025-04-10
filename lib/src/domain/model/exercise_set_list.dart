import 'package:flutter/foundation.dart';
import 'exercise_set.dart';

/// エクササイズセットのCollectionドメインモデル
class ExerciseSetList extends ChangeNotifier {
  /// セットリスト
  final List<ExerciseSet> setList;

  /// コンストラクタ
  ///
  /// [setList] セットリスト, 必須
  ExerciseSetList({required this.setList});

  /// セットリストの取得
  ///
  /// リストの要素は変更不可
  List<ExerciseSet> get asList => List.unmodifiable(setList);

  /// セットの追加
  void add(ExerciseSet set) {
    setList.add(set);
    notifyListeners();
  }

  /// セットの削除
  void remove(int index) {
    if (index >= 0 && index < setList.length) {
      setList.removeAt(index);
      notifyListeners();
    }
  }

  /// セットの更新
  void update(int index, ExerciseSet updatedSet) {
    if (index >= 0 && index < setList.length) {
      setList[index] = updatedSet;
      notifyListeners();
    }
  }

  /// セットの数を取得
  int get length => setList.length;

  /// セットが空かどうかを確認
  bool get isEmpty => setList.isEmpty;

  /// セットが空でないかどうかを確認
  bool get isNotEmpty => setList.isNotEmpty;
}
