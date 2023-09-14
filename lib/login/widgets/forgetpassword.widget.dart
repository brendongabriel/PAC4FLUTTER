import 'package:flutter/material.dart';

class ForgetPasswordField extends StatefulWidget {
  const ForgetPasswordField({super.key});

  @override
  State<ForgetPasswordField> createState() => _ForgetPasswordFieldState();
}

class _ForgetPasswordFieldState extends State<ForgetPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Coloque aqui a lógica para lidar com o "Esqueceu a senha?"
      },
      child: const Text(
        "Esqueceu a senha?",
        style: TextStyle(
          color: Color.fromARGB(255, 14, 64, 6),
          decoration: TextDecoration.none,  
        ),
      ),
    );
  }
}