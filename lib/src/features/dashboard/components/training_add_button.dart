import 'package:flutter/material.dart';

// ダッシュボード - トレーニング追加ボタン
//
// ボタン押下した時、以下の選択肢を表示してトレーニングログ画面に遷移させる
//   - 新規追加
//   - 履歴から追加
class TrainingAddButton extends StatelessWidget {
  const TrainingAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red[300],
      elevation: 0,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.add_circle_outline),
                    title: const Text(
                      '新規作成',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/add_training');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.history, color: Colors.grey[700]),
                    title: const Text(
                      '履歴からコピー',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // TODO: 履歴からコピー機能の実装
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.file_copy_outlined, color: Colors.grey[700]),
                    title: const Text(
                      'テンプレートから作成',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // TODO: テンプレートから作成機能の実装
                      Navigator.pop(context);
                    },
                  ),
                  Divider(color: Colors.grey[200]),
                ],
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
