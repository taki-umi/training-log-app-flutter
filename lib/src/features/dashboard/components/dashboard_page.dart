import 'package:flutter/material.dart';
import 'package:training_log_app/src/core/components/base_page.dart';

// DashboardPage - ダッシュボード画面
//
// ダッシュボード画面の元となるページです。
class DashboardPage extends BasePage {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Dashboard Page'),
    );
  }
}
