import 'package:flutter/material.dart';
import 'package:training_log_app/src/core/components/base_page.dart';
import 'package:training_log_app/src/features/dashboard/components/training_log_list.dart';

import 'training_add_button.dart';
import 'training_log_calendar.dart';

// DashboardPage - ダッシュボード画面
//
// ダッシュボード画面の元となるページです。
class DashboardPage extends BasePage {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: ListView(
      //   child: Column(
      //     children: [
      //       const Center(
      //         child: Text('Dashboard Page1'),
      //       ),
      //       const TrainingLogCalendar(), // カレンダー コンポーネント
      //       const TrainingLogList(), // トレーニングリスト コンポーネント
      //     ],
      //   ),
      // ),
      body: ListView(
        children: const [
          Center(
            child: Text('Dashboard Page1'),
          ),
          TrainingLogCalendar(), // カレンダー コンポーネント
          TrainingLogList(), // トレーニングリスト コンポーネント
        ],
      ),
      floatingActionButton: const TrainingAddButton(), // トレーニング追加ボタン
    );
  }
}
