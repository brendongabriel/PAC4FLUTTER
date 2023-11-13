import 'package:flutter/material.dart';
import 'package:pac/cadastro/cadastro.view.dart';
import 'package:http/http.dart' as http;
import 'package:pac/home/home.view.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color.fromRGBO(118, 166, 68, 1)],
              stops: [0.0, 0.7],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 80),
                  Image.asset(
                    "assets/images/logo.png",
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 60),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      enabled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 14, 64, 6),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _senhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Senha',
                      enabled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 14, 64, 6),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          if (_emailController.text.isEmpty ||
                              _senhaController.text.isEmpty) {
                            showSuccessMessage(
                                "Preencha todos os campos para continuar.");
                          } else {
                            _loginButtonPressed();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.green[900],
                        ).copyWith(
                          minimumSize:
                              MaterialStateProperty.all(const Size(0, 40)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 45.0)),
                        ),
                        child: const Text('ENTRAR'),
                      ),
                      const SizedBox(width: 10), // Espaçamento entre os botões
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CadastroView(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.green[900],
                        ).copyWith(
                          minimumSize:
                              MaterialStateProperty.all(const Size(0, 40)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 30.0)),
                        ),
                        child: const Text('CRIAR CONTA'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loginButtonPressed() async {
    try {
      final response = await http.post(
        Uri.parse('https://app-carteira.wnology.io/api/v1/login'),
        body: {
          'email': _emailController.text,
          'password': _senhaController.text,
        },
      );

      if (response.statusCode == 200) {
        print('Login bem-sucedido!');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', response.body.toString());
        _emailController.clear();
        _senhaController.clear();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );
      } else {
        print('Erro ao fazer login: ${response.statusCode}');
        showSuccessMessage("Credenciais inválidas. Tente novamente.");
        _emailController.clear();
        _senhaController.clear();
      }
    } catch (error) {
      print('Erro ao fazer login: $error');
    }
  }

  void showSuccessMessage(String message) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(message),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text("Ok"))
        ],
      ),
    );
  }
}
