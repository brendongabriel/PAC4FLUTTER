import 'package:flutter/material.dart';
import 'package:pac/cadastro/cadastro.view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
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
                  const TextField(
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
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      //labelText: 'Senha',
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
                  Row( // Utilize um Row para colocar os botões lado a lado
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // Ação para o botão "ENTRAR"
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.green[900],
                        ).copyWith(
                          minimumSize: MaterialStateProperty.all(const Size(0, 40)),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 45.0)),
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
                          minimumSize: MaterialStateProperty.all(const Size(0, 40)),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 30.0)),
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
}