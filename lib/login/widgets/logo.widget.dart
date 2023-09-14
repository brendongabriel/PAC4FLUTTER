import 'package:flutter/material.dart';

class LogoIcon extends StatefulWidget {
  const LogoIcon({super.key});

  @override
  State<LogoIcon> createState() => _LogoIconState();
}

class _LogoIconState extends State<LogoIcon> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo.png",
      width: 100,
      height: 100,
    );
  }
}