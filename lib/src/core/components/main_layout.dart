import 'package:flutter/material.dart';
import 'package:training_log_app/src/core/components/custom_navigation_bar.dart';
import 'package:training_log_app/src/features/dashboard/components/dashboard_page.dart';

import 'custom_title_bar.dart';

// MainLayout - メインレイアウト コンポーネント
//
// メイン画面の元となるページです。
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 選択されたページを取得
    Widget page = _getPageByIndex(_selectedIndex);

    return Scaffold(
      appBar: const CustomTitleBar(),
      body: page,
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _selectedIndex,
        onIndexChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  // _getPageByIndex - 選択されたページを取得
  //
  // @param selectedIndex 選択されたページのインデックス
  // @return Widget 選択されたページ
  // @throws UnimplementedError 選択されたページが見つからない場合
  Widget _getPageByIndex(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const DashboardPage();
      case 1:
        return const Placeholder();
      case 2:
        return const Placeholder();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
  }
}
