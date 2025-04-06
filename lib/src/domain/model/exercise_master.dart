import 'exercise.dart';

class ExerciseMaster {
  static final List<Exercise> exercises = [
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

  static List<Exercise> getExercises() {
    return List.unmodifiable(exercises);
  }

  static Exercise? getExerciseById(String id) {
    try {
      return exercises.firstWhere((exercise) => exercise.id == id);
    } catch (e) {
      return null;
    }
  }
}
