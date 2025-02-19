import 'package:flutter/material.dart';

// TitleBar - 画面上部のタイトルバーコンポーネント
//
// 画面上部のタイトルバーコンポーネントは、画面のタイトルを表示するためのコンポーネントです。
class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: CircleAvatar(
          // backgroundImage: NetworkImage(photoUrl),
          backgroundColor: Colors.white, // 背景色
          radius: 16, // 表示したいサイズの半径を指定
          child: Icon(Icons.person),
        ),
        onPressed: () {
          // TODO: Person action
        },
      ),
      title: const Text('Training App(仮)'),
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
