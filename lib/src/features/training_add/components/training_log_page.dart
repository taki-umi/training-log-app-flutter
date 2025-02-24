import 'package:flutter/material.dart';
import 'package:training_log_app/src/core/components/base_page.dart';

class TrainingLogPage extends BasePage {
  const TrainingLogPage({super.key});

  static const title = 'Training Log Page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // 1つ前の画面に戻る
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: const Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              // TODO: Person action
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(title),
      ),
    );
  }
}
