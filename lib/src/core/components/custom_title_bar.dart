import 'package:flutter/material.dart';

import 'user_icon_button.dart';

// TitleBar - 画面上部のタイトルバーコンポーネント
//
// 画面上部のタイトルバーコンポーネントは、画面のタイトルを表示するためのコンポーネントです。
class CustomTitleBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTitleBar({super.key});

  static const title = 'Training App(仮)';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const UserIconButton(), // ユーザーアイコンボタン
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.red[300],
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // TODO: Person action
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
