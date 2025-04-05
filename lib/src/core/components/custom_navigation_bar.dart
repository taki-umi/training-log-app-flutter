import 'package:flutter/material.dart';

// CustomNavigationBar - 画面下部のナビゲーションバーコンポーネント
//
// 画面下部のナビゲーションバーコンポーネントは、画面のナビゲーションを表示するためのコンポーネントです。
class CustomNavigationBar extends StatelessWidget {
  // コンストラクタ
  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  final int currentIndex;
  final ValueChanged<int> onIndexChanged;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onIndexChanged,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timeline),
          label: 'Timeline',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Charts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
