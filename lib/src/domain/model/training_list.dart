// トレーニング記録リストのドメインモデル

import 'training.dart';

class TrainingList {
  final List<Training> trainingList;

  // コンストラクタ
  TrainingList({required this.trainingList});

  // トレーニング記録リストの取得
  //
  // リストの要素は変更不可
  List<Training> get asList => List.unmodifiable(trainingList);

  // トレーニング記録リストの追加
  void add(Training training) {
    trainingList.add(training);
  }
}
