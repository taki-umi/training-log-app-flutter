import 'package:flutter/material.dart';
import 'src/core/components/main_layout.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'src/features/training_form/components/training_form_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('ja_JP');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const title = 'Training Log App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: MainLayout(),
      // 以下でルーティングを設定
      routes: {
        '/dashboard': (context) => const MainLayout(),
        '/add_training': (context) => const TrainingFormPage(),
      },
    );
  }
}
