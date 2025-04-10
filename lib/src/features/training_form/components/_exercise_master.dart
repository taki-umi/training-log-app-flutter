import 'package:training_log_app/src/domain/model/exercise.dart';
import 'package:training_log_app/src/domain/model/exercise_set.dart';
import 'package:training_log_app/src/domain/model/exercise_set_list.dart';

/// エクササイズのマスターデータ
class ExerciseMaster {
  /// エクササイズの一覧を取得
  static List<Exercise> getExercises() {
    return [
      Exercise(
        id: '1',
        name: 'ベンチプレス',
        sets: ExerciseSetList(setList: []),
      ),
      Exercise(
        id: '2',
        name: 'スクワット',
        sets: ExerciseSetList(setList: []),
      ),
      Exercise(
        id: '3',
        name: 'デッドリフト',
        sets: ExerciseSetList(setList: []),
      ),
      Exercise(
        id: '4',
        name: 'ショルダープレス',
        sets: ExerciseSetList(setList: []),
      ),
      Exercise(
        id: '5',
        name: 'ラットプルダウン',
        sets: ExerciseSetList(setList: []),
      ),
      Exercise(
        id: '6',
        name: 'バーベルロウ',
        sets: ExerciseSetList(setList: []),
      ),
      Exercise(
        id: '7',
        name: 'レッグプレス',
        sets: ExerciseSetList(setList: []),
      ),
      Exercise(
        id: '8',
        name: 'アームカール',
        sets: ExerciseSetList(setList: []),
      ),
      Exercise(
        id: '9',
        name: 'トライセプスプッシュダウン',
        sets: ExerciseSetList(setList: []),
      ),
      Exercise(
        id: '10',
        name: 'カーフレイズ',
        sets: ExerciseSetList(setList: []),
      ),
    ];
  }

  /// サンプルエクササイズの一覧を取得（セット情報付き）
  static List<Exercise> getSampleExercises() {
    return [
      Exercise(
        id: '1',
        name: 'ベンチプレス',
        sets: ExerciseSetList(
          setList: [
            ExerciseSet(weight: 60.0, reps: 10),
            ExerciseSet(weight: 70.0, reps: 8),
            ExerciseSet(weight: 80.0, reps: 6),
          ],
        ),
      ),
      Exercise(
        id: '2',
        name: 'スクワット',
        sets: ExerciseSetList(
          setList: [
            ExerciseSet(weight: 80.0, reps: 10),
            ExerciseSet(weight: 90.0, reps: 8),
            ExerciseSet(weight: 100.0, reps: 6),
          ],
        ),
      ),
      Exercise(
        id: '3',
        name: 'デッドリフト',
        sets: ExerciseSetList(
          setList: [
            ExerciseSet(weight: 100.0, reps: 8),
            ExerciseSet(weight: 120.0, reps: 6),
            ExerciseSet(weight: 140.0, reps: 4),
          ],
        ),
      ),
    ];
  }
}
