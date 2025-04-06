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
    return {
      'reps': reps,
      'weight': weight,
      'restInterval': restInterval,
    };
  }

  factory ExerciseSet.fromJson(Map<String, dynamic> json) {
    return ExerciseSet(
      reps: json['reps'] as int,
      weight: json['weight'] as double,
      restInterval: json['restInterval'] as int,
    );
  }
}

class Exercise {
  final String id;
  final String name;
  final List<ExerciseSet> sets;

  Exercise({
    required this.id,
    required this.name,
    List<ExerciseSet>? sets,
  }) : sets = sets ?? List.generate(3, (_) => ExerciseSet());

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sets': sets.map((set) => set.toJson()).toList(),
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      sets: (json['sets'] as List)
          .map((set) => ExerciseSet.fromJson(set as Map<String, dynamic>))
          .toList(),
    );
  }

  // セット数を変更する
  Exercise updateSetCount(int count) {
    if (count < 1) count = 1;
    final newSets = List.generate(
      count,
      (index) => index < sets.length ? sets[index] : ExerciseSet(),
    );
    return copyWith(sets: newSets);
  }

  // 特定のセットを更新する
  Exercise updateSet(int index, ExerciseSet newSet) {
    if (index < 0 || index >= sets.length) return this;
    final newSets = List<ExerciseSet>.from(sets);
    newSets[index] = newSet;
    return copyWith(sets: newSets);
  }
}
