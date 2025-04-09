// エクササイズセットのドメインモデル
class ExerciseSet {
  final int reps;
  final double weight;
  final int restInterval;

  ExerciseSet({
    this.reps = 0,
    this.weight = 0,
    this.restInterval = 60,
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
