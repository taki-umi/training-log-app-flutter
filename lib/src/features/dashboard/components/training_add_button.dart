import 'package:flutter/material.dart';

class TrainingAddButton extends StatelessWidget {
  const TrainingAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red[300],
      onPressed: () {
        // TODO: トレーニング追加画面に遷移
      },
      child: Icon(Icons.add),
    );
  }
}
