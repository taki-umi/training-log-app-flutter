import 'package:flutter/material.dart';
import 'package:training_log_app/src/domain/model/exercise.dart';
import 'package:training_log_app/src/domain/model/exercise_list.dart';
import 'package:training_log_app/src/domain/model/exercise_set.dart';

class ExerciseInput extends StatelessWidget {
  final Exercise exercise;
  final ExerciseList exerciseList;

  const ExerciseInput({
    super.key,
    required this.exercise,
    required this.exerciseList,
  });

  @override
  Widget build(BuildContext context) {
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
                final set = exercise.sets[index];
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
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('セットの削除'),
                          content: const Text('このセットを削除してもよろしいですか？'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('キャンセル'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('削除'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    final newSets = List<ExerciseSet>.from(exercise.sets)
                      ..removeAt(index);
                    final updatedExercise = exercise.copyWith(sets: newSets);
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
                                        : '',
                                  ),
                                  onChanged: (value) {
                                    final weight = double.tryParse(value) ?? 0;
                                    final newSet = set.copyWith(weight: weight);
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
                                    text:
                                        set.reps > 0 ? set.reps.toString() : '',
                                  ),
                                  onChanged: (value) {
                                    final reps = int.tryParse(value) ?? 0;
                                    final newSet = set.copyWith(reps: reps);
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
                  final newSets = List<ExerciseSet>.from(exercise.sets)
                    ..add(ExerciseSet());
                  final updatedExercise = exercise.copyWith(sets: newSets);
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
