import 'package:flutter/material.dart';
import 'package:pac/login/login.view.dart';

class BotaoCadastro extends StatefulWidget {
  const BotaoCadastro({super.key});

  @override
  State<BotaoCadastro> createState() => _BotaoCadastroState();
}

class _BotaoCadastroState extends State<BotaoCadastro> {
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginView()
          )
        );
      },
      child: const Text(
        "Finalizar Cadastro",
        style: TextStyle(
          color: Color.fromARGB(255, 234, 234, 234),
          decoration: TextDecoration.none,  
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Ajuste o valor do raio conforme necessário
        ),
      ),
    );
  }
}