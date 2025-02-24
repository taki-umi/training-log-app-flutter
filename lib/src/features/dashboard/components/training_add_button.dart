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
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                  height: 200,
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.open_in_new),
                        title: Text('新規追加'),
                        onTap: () {
                          const routeName = '/add_training';
                          Navigator.pop(context);
                          Navigator.pushNamed(context, routeName);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.history),
                        title: Text('履歴から追加'),
                        onTap: () {
                          // Navigator.pushNamed(context, '/add_training'); // TODO: 遷移画面追加
                        },
                      ),
                    ],
                  ));
            });
      },
      child: Icon(Icons.add),
    );
  }
}
