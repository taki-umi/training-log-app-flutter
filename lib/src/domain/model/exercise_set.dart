// エクササイズセットのドメインモデル
class ExerciseSet {
  // 回数
  final int reps;
  // 重量
  final double weight;
  // 休憩時間
  final int restInterval;

  // コンストラクタ
  //
  // reps: 回数, 初期値は0
  // weight: 重量, 初期値は0.0
  // restInterval: 休憩時間, 初期値は0
  ExerciseSet({
    this.reps = 0,
    this.weight = 0.0,
    this.restInterval = 0,
  });

  ExerciseSet copyWith({
    int? reps,
    double? weight,
    int? restInterval,
  }) {
    return ExerciseSet(
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      restInterval: restInterval ?? this.restInterval,
    );
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        'reps': reps,
        'weight': weight,
        'restInterval': restInterval,
      };
    } catch (e) {
      print('ExerciseSetのtoJsonでエラーが発生しました: $e');
      rethrow;
    }
  }

  factory ExerciseSet.fromJson(Map<String, dynamic> json) {
    return ExerciseSet(
      reps: json['reps'] as int,
      weight: json['weight'] as double,
      restInterval: json['restInterval'] as int,
    );
  }
}
