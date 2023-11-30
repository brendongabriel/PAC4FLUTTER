import 'package:flutter/material.dart';
import 'package:pac/login/login.view.dart';
import 'package:pac/home/home.view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinanceAPP',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: const LoginView()//const LoginView(),
      
    );
  }
}
