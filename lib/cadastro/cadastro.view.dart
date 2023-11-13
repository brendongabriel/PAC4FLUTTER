import 'package:flutter/material.dart';
import 'package:pac/login/login.view.dart';
import 'package:http/http.dart' as http;

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController1 = TextEditingController();
  final TextEditingController _senhaController2 = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro'),
          backgroundColor: Colors.green[900],
        ),
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
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(22),
              children: [
                const SizedBox(height: 100),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Digite seus dados abaixo para criar sua conta:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Nome Completo',
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
                SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
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
                  controller: _senhaController1,
                  obscureText: true,
                  decoration: InputDecoration(
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
                const SizedBox(height: 10),
                TextField(
                  controller: _senhaController2,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirme sua Senha',
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  //child: TermosCheck(),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_emailController.text.isEmpty ||
                        _senhaController1.text.isEmpty ||
                        _senhaController2.text.isEmpty ||
                        _nameController.text.isEmpty) {
                      showSuccessMessage(
                          "Preencha todos os campos para continuar.");
                      return;
                    } else {
                      _registerAccountPressed();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    "Finalizar Cadastro",
                    style: TextStyle(
                      color: Color.fromARGB(255, 234, 234, 234),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                const SizedBox(height: 330),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _registerAccountPressed() async {
    if (!_emailController.text.contains('@') ||
        !_emailController.text.contains('.')) {
      showSuccessMessage(
          "Digite um email válido. Verifique os dados e tente novamente.");
      _senhaController2.clear();
      _senhaController1.clear();
    }

    if (_nameController.text.split(" ").length < 2) {
      showSuccessMessage(
          "Digite seu nome completo. Verifique os dados e tente novamente.");
      _senhaController2.clear();
      _senhaController1.clear();
      return;
    }

    if (_senhaController1.text != _senhaController2.text) {
      showSuccessMessage(
          "As senhas não coincidem. Verifique os dados e tente novamente.");
      _senhaController2.clear();
      _senhaController1.clear();
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://app-carteira.wnology.io/api/v1/user'),
        body: {
          'email': _emailController.text,
          'password': _senhaController1.text,
          'name': _nameController.text
        },
      );

      if (response.statusCode == 200) {
        print('Usuário criado com sucesso!');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
        );
      } else if (response.statusCode == 409) {
        showSuccessMessage(
            "Este e-mail já está em uso. Por favor, escolha outro.");
        _emailController.clear();
        _senhaController2.clear();
        _senhaController1.clear();
      } else {
        print('Erro ao fazer login: ${response.statusCode}');
        showSuccessMessage(
            "Erro ao criar usuário. Verifique os dados e tente novamente.");
        _senhaController2.clear();
        _senhaController1.clear();
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
