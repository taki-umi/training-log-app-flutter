import 'package:flutter/material.dart';
import 'package:training_log_app/src/core/components/base_page.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Text('Dashboard Page1'),
            ),
            const TrainingLogCalendar(), // カレンダー コンポーネント
          ],
        ),
      ),
      floatingActionButton: const TrainingAddButton(), // トレーニング追加ボタン
    );
  }
}
