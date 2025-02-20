import 'package:flutter/material.dart';

class UserIconButton extends StatelessWidget {
  const UserIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        // 画像を表示する場合はここに画像のURLを指定
        // backgroundImage: NetworkImage(photoUrl),
        backgroundColor: Colors.white, // 背景色
        radius: 16, // 表示したいサイズの半径を指定
        child: Icon(Icons.person),
      ),
      onPressed: () {
        // TODO: Person action
      },
    );
  }
}
