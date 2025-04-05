import 'package:flutter/material.dart';
import 'package:training_log_app/src/core/components/base_page.dart';

class TrainingLogPage extends BasePage {
  const TrainingLogPage({super.key});

  static final String title = DateTime.now().toLocal().toString().split(' ')[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // 1つ前の画面に戻る
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              // TODO: Person action
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Training Log Page'),
            ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.open_in_new),
                            title: Text('New Training'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/add_training');
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.redAccent.shade100,
              ),
              icon: Icon(Icons.add, color: Colors.grey.shade700),
              label: Text(
                'Add Training',
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
