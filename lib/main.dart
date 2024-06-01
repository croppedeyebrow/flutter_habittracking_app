import 'package:flutter/material.dart';
import 'package:flutter_habittracking_app/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진이 초기화되도록 합니다.
  await Hive.initFlutter(); // Hive를 초기화합니다.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Habit App',
      home: const HomePage(),
    );
  }
}
