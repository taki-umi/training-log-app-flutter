import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_log_app/src/core/components/base_page.dart';
import 'package:training_log_app/src/domain/model/exercise_list.dart';
import 'package:training_log_app/src/domain/model/exercise_set_list.dart';
import 'package:training_log_app/src/domain/model/training_session.dart';
import 'package:training_log_app/src/domain/service/training_session_service.dart';
import 'package:training_log_app/src/features/training_form/components/exercise_input.dart';
import 'package:training_log_app/src/features/training_form/components/exercise_selection_modal.dart';
import 'package:training_log_app/src/persistence/training_firebase_repository.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;

class TrainingFormPage extends BasePage {
  final TrainingSession? trainingSession;
  final bool isEditMode;

  const TrainingFormPage({
    super.key,
    this.trainingSession,
    this.isEditMode = false,
  });

  String _formatDate(DateTime date) {
    final formatter = DateFormat.yMMMEd('ja_JP');
    try {
      return formatter.format(date);
    } catch (e) {
      return '${date.year}年${date.month}月${date.day}日';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExerciseList('', exerciseList: []),
      child: Builder(
        builder: (context) {
          final exerciseList = context.watch<ExerciseList>();
          final date = trainingSession?.trainingDate ?? DateTime.now();

          // トレーニングセッションサービスを初期化
          final repository = TrainingFirebaseRepository();
          final service = TrainingSessionService(repository);

          // 編集モードの場合、既存のデータを読み込む
          if (isEditMode && trainingSession != null) {
            exerciseList.exerciseList.clear();
            exerciseList.exerciseList
                .addAll(trainingSession!.exerciseList.asList);
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                _formatDate(date),
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.timer, color: Colors.black87),
                  onPressed: () {
                    // TODO: タイマー機能の実装
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: Colors.black87),
                  onPressed: () {
                    // TODO: その他のオプション実装
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (exerciseList.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 32.0),
                              child: Text(
                                'トレーニングを追加してください',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ...exerciseList.asList.map((exercise) {
                          return ExerciseInput(
                            exercise: exercise,
                            exerciseList: exerciseList,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 24.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[300],
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.9,
                              ),
                              builder: (context) => ExerciseSelectionModal(
                                exerciseList: exerciseList,
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, size: 24),
                              SizedBox(width: 8),
                              Text(
                                '種目を追加',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () async {
                            if (exerciseList.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('トレーニングを追加してください'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              return;
                            }

                            try {
                              developer.log('トレーニングセッションの作成を開始',
                                  name: 'TrainingFormPage');

                              // テキストから数値型に変換
                              final convertedExerciseList = ExerciseList(
                                '',
                                exerciseList:
                                    exerciseList.asList.map((exercise) {
                                  final convertedSets =
                                      exercise.sets.asList.map((set) {
                                    return set.copyWith(
                                      weight: set.weight,
                                      reps: set.reps,
                                    );
                                  }).toList();

                                  return exercise.copyWith(
                                    sets:
                                        ExerciseSetList(setList: convertedSets),
                                  );
                                }).toList(),
                              );

                              // トレーニングセッションを作成
                              final session = TrainingSession(
                                userId: 'USER01', // TODO: いったん仮でUSER_IDを固定
                                trainingDate: date,
                                startTime: '',
                                endTime: '',
                                exerciseList: convertedExerciseList,
                                notes: '',
                                photoUrl: '',
                              );

                              developer.log('トレーニングセッションを作成しました',
                                  name: 'TrainingFormPage');

                              if (isEditMode && trainingSession != null) {
                                // 編集モードの場合は更新
                                final updatedSession =
                                    trainingSession!.copyWith(
                                  exerciseList: convertedExerciseList,
                                );
                                await service
                                    .updateTrainingSession(updatedSession);
                                developer.log('トレーニングセッションを更新しました',
                                    name: 'TrainingFormPage');
                              } else {
                                // 新規作成モードの場合は保存
                                await service.saveTrainingSession(session);
                                developer.log('トレーニングセッションを保存しました',
                                    name: 'TrainingFormPage');
                              }

                              // 成功メッセージを表示
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(isEditMode
                                        ? 'トレーニングを更新しました'
                                        : 'トレーニングを保存しました'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );

                                // 前の画面に戻る
                                Navigator.pop(context);
                              }
                            } catch (e, stackTrace) {
                              developer.log(
                                'トレーニング保存中にエラーが発生しました',
                                name: 'TrainingFormPage',
                                error: e,
                                stackTrace: stackTrace,
                              );

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('エラーが発生しました: $e'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            isEditMode ? '修正完了' : 'ワークアウト完了',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
