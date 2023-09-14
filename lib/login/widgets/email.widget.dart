import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  const EmailField({super.key});

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        //labelText: 'Email',
        hintText: 'Email',
        enabled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 255, 255, 255)
          ),
        ),
          focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 14, 64, 6),
          ),
        ),
      ),
    );
  }
}