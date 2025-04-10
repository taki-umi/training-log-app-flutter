import 'package:flutter/material.dart';
import 'package:training_log_app/src/domain/model/exercise.dart';
import 'package:training_log_app/src/domain/model/exercise_list.dart';
import 'package:training_log_app/src/domain/model/exercise_set.dart';
import 'package:training_log_app/src/domain/model/exercise_set_list.dart';

/// トレーニングフォームのエクササイズ入力コンポーネント
class ExerciseInput extends StatelessWidget {
  // TODO: エクササイズ入力用のモデルを作成して、使用するようにする、重量と回数のフィールド型はStringにする予定
  final Exercise exercise;
  final ExerciseList exerciseList;

  const ExerciseInput({
    super.key,
    required this.exercise,
    required this.exerciseList,
  });

  @override
  Widget build(BuildContext context) {
    String textWeight = '';
    String textReps = '';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    exercise.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        exerciseList.remove(exercise.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: exercise.sets.length,
              itemBuilder: (context, index) {
                final set = exercise.sets.asList[index];
                return Dismissible(
                  key: Key('set_${exercise.id}_$index'),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    if (index == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('最初のセットは削除できません'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return false;
                    }
                    return true;
                  },
                  onDismissed: (direction) {
                    final newSets = List<ExerciseSet>.from(exercise.sets.asList)
                      ..removeAt(index);
                    final updatedExercise = exercise.copyWith(
                      sets: ExerciseSetList(setList: newSets),
                    );
                    exerciseList.update(updatedExercise);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('セットを削除しました'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16.0),
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 32,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                // TODO: 重量フォームの入力しにくさを改善する
                                child: TextField(
                                  decoration: const InputDecoration(
                                    labelText: 'kg',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: TextEditingController(
                                      text: set.weight > 0
                                          ? set.weight.toString()
                                          : '')
                                    ..selection = TextSelection.fromPosition(
                                        TextPosition(
                                            offset: set.weight > 0
                                                ? set.weight.toString().length -
                                                    2 // 整数部分にフォーカス
                                                : 0)),
                                  onChanged: (value) {
                                    textWeight = value;
                                    final newWeight =
                                        double.tryParse(textWeight) ?? 0.0;
                                    final newSet =
                                        set.copyWith(weight: newWeight);
                                    final updatedExercise =
                                        exercise.updateSet(index, newSet);
                                    exerciseList.update(updatedExercise);
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text('×'),
                              ),
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    labelText: '回',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: TextEditingController(
                                      text: set.reps > 0
                                          ? set.reps.toString()
                                          : '')
                                    ..selection = TextSelection.fromPosition(
                                        TextPosition(
                                            offset: set.reps > 0
                                                ? set.reps.toString().length
                                                : 0)),
                                  onChanged: (value) {
                                    textReps = value;
                                    final newReps = int.tryParse(textReps) ?? 0;
                                    final newSet = set.copyWith(reps: newReps);
                                    final updatedExercise =
                                        exercise.updateSet(index, newSet);
                                    exerciseList.update(updatedExercise);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  final newSets = List<ExerciseSet>.from(exercise.sets.asList)
                    ..add(ExerciseSet());
                  final updatedExercise = exercise.copyWith(
                    sets: ExerciseSetList(setList: newSets),
                  );
                  exerciseList.update(updatedExercise);
                },
                icon: const Icon(Icons.add, size: 16),
                label: const Text(
                  'セットを追加',
                  style: TextStyle(fontSize: 12),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red[700],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
