import 'exercise_set.dart';

// エクササイズ記録のドメインモデル
class Exercise {
  /// エクササイズID
  final String id;

  /// エクササイズ名
  final String name;

  /// セットリスト
  final List<ExerciseSet> sets;

  /// コンストラクタ
  ///
  /// [id] エクササイズID
  /// [name] エクササイズ名
  /// [sets] セットリスト
  ///
  Exercise({
    required this.id,
    required this.name,
    List<ExerciseSet>? sets,
  }) : sets = sets ?? [ExerciseSet()];

  /// コピー
  ///
  /// [id] エクササイズID
  /// [name] エクササイズ名
  /// [sets] セットリスト
  ///
  Exercise copyWith({
    String? id,
    String? name,
    List<ExerciseSet>? sets,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      sets: sets ?? this.sets,
    );
  }

  /// JSONに変換
  ///
  /// エクササイズのJSON表現を返す
  ///
  Map<String, dynamic> toJson() {
    try {
      return {
        'id': id,
        'name': name,
        'sets': sets.map((set) => set.toJson()).toList(),
      };
    } catch (e) {
      print('ExerciseのtoJsonでエラーが発生しました: $e');
      rethrow;
    }
  }

  /// JSONからエクササイズを作成
  ///
  /// [json] JSON表現
  ///
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      sets: (json['sets'] as List)
          .map((set) => ExerciseSet.fromJson(set as Map<String, dynamic>))
          .toList(),
    );
  }

  /// セット数を変更する
  ///
  /// [count] セット数
  ///
  Exercise updateSetCount(int count) {
    if (count < 1) count = 1;
    final newSets = List.generate(
      count,
      (index) => index < sets.length ? sets[index] : ExerciseSet(),
    );
    return copyWith(sets: newSets);
  }

  /// 特定のセットを更新する
  ///
  /// [index] セットのインデックス
  /// [newSet] 新しいセット
  ///
  Exercise updateSet(int index, ExerciseSet newSet) {
    if (index < 0 || index >= sets.length) return this;
    final newSets = List<ExerciseSet>.from(sets);
    newSets[index] = newSet;
    return copyWith(sets: newSets);
  }
}
