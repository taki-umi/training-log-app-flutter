import 'package:flutter/material.dart';
import 'src/core/components/main_layout.dart';

void main() {
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
    );
  }
}
