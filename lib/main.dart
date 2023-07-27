import 'package:flutter/material.dart';
import 'package:scanner_app/screens/Home_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scanner App',
      theme: ThemeData(
        fontFamily: 'Times New Roman',
      ),
      home: const HomeScreen(),
    );
  }
}
