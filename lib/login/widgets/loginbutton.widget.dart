import 'package:flutter/material.dart';
import 'package:pac/cadastro/cadastro.view.dart';
import 'package:pac/home/home.view.dart';

class LoginButtonField extends StatefulWidget {
  const LoginButtonField({super.key});

  @override
  State<LoginButtonField> createState() => _LoginButtonFieldState();
}

class _LoginButtonFieldState extends State<LoginButtonField> {
  @override
  Widget build(BuildContext context) {
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 0), // Espaço entre os botões 
          child: Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeView()
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), 
                ),
                backgroundColor: Colors.green[900] 
              ).copyWith(
                minimumSize: MaterialStateProperty.all(const Size(0, 40)), // Ajuste a altura do botão (40 é um exemplo)
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 45.0)), 
              ),
              child: const Text('ENTRAR'),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 0), 
          child: Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CadastroView(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Ajuste o valor do raio conforme necessário
                ),
                backgroundColor: Colors.green[900], // Cor de fundo azul para o botão "Logar"
              ).copyWith(
                minimumSize: MaterialStateProperty.all(const Size(0, 40)), // Ajuste a altura do botão (40 é um exemplo)
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 30.0)), // Ajuste o padding horizontal conforme necessário
              ),
              child: const Text('CRIAR CONTA'),
            ),
          ),
        ),
      ],
    );
  }
}