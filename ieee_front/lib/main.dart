import 'package:flutter/material.dart';
import 'package:ieee/login_screen.dart';

void main() async {

  await initialization(null);

  runApp(const MyApp());
}
Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 3));
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: const LoginScreen(),
    );
  }
}