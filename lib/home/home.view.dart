import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? _user = ''; // Variável para armazenar o user
  String _name = ''; // Variável para armazenar o e-mail
  Map<String, dynamic>? _userObj; // Usando Map para representar o JSON

  @override
  void initState() {
    super.initState();
    _loadEmailFromPreferences();
  }

  // Método para carregar o e-mail armazenado em shared_preferences
  void _loadEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _user = prefs.getString('user') ?? '';
    });

    // Decodificar o JSON para um Map<String, dynamic>
    _userObj = jsonDecode(_user!) as Map<String, dynamic>;

    // Verificar se a chave 'email' existe antes de acessá-la
    if (_userObj!.containsKey('firstName')) {
      _name = _userObj!['firstName'].split(' ')[0];
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinanceApp'),
        backgroundColor: Colors.green[900],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color.fromRGBO(118, 166, 68, 1)],
          stops: [0.0, 0.7], // Cores do degradê
        ),
      ),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(12),
          children: [
            Text(
              'Olá $_name!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Bem vindo ao FinanceApp!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
