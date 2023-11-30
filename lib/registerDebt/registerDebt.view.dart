import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterDebt extends StatefulWidget {
  const RegisterDebt({Key? key}) : super(key: key);

  @override
  _RegisterDebtState createState() => _RegisterDebtState();
}

class _RegisterDebtState extends State<RegisterDebt> {
  String? _user = ''; // Variável para armazenar o user
  String _email = ''; // Variável para armazenar o e-mail
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
    if (_userObj!.containsKey('email')) {
      _email = _userObj!['email'].split(' ')[0];
    }
  }

  String _nameDebt = '';
  String _category = 'salario'; // Valor inicial fixo para categoria
  double _value = 0.0;
  double _months = 0.0;
  double _deadline = 0.0;
  String _type = 'divida'; // Valor inicial fixo para tipo

  List<String> categories = ["salario", "lazer", "estudo", "comida", "diversos"];
  List<String> types = ["divida", "receita"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinanceApp'),
        backgroundColor: Colors.green[900],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color.fromRGBO(118, 166, 68, 1)],
            stops: [0.0, 0.7], // Cores do degradê
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    _nameDebt = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Name'),
              ),
              DropdownButton<String>(
                value: _category.isNotEmpty ? _category : categories.first,
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                hint: Text('Category'),
              ),
              TextField(
                onChanged: (value) {
                  try {
                    setState(() {
                      _value = double.parse(value);
                    });
                  } catch (e) {
                    // Lidar com a exceção de formato inválido
                    print('Erro ao converter para número: $e');
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Value'),
              ),
              TextField(
                onChanged: (value) {
                  try {
                    setState(() {
                      _months = double.parse(value);
                    });
                  } catch (e) {
                    // Lidar com a exceção de formato inválido
                    print('Erro ao converter para número: $e');
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Months'),
              ),
              TextField(
                onChanged: (value) {
                  try {
                    setState(() {
                      _deadline = double.parse(value);
                    });
                  } catch (e) {
                    // Lidar com a exceção de formato inválido
                    print('Erro ao converter para número: $e');
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Deadline'),
              ),
              DropdownButton<String>(
                value: _type.isNotEmpty ? _type : types.first,
                onChanged: (value) {
                  setState(() {
                    _type = value!;
                  });
                },
                items: types.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                hint: Text('Type'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[900], // Cor de fundo do botão
                  // Adicione mais propriedades conforme necessário
                ),
                onPressed: () {
                  print(
                      'Nome: $_nameDebt, Categoria: $_category, Valor: $_value, Meses: $_months, Prazo: $_deadline, Tipo: $_type');
                  if (_nameDebt == '' ||
                      _category == '' ||
                      _value == 0.0 ||
                      _months == 0.0 ||
                      _deadline == 0.0 ||
                      _type == '') {
                    showSuccessMessage(
                        "Preencha todos os campos para continuar.");
                    return;
                  } else {
                    _registerDebtPressed();
                  }
                  // Aqui você pode realizar ações com os valores fornecidos
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerDebtPressed() async {
    print(_email);
    try {
      final response = await http.post(
        Uri.parse('https://app-carteira.wnology.io/api/v1/debt'),
        body: {
          "name": _nameDebt,
          "category": _category,
          "type": _type,
          "value": _value.toString(),
          "months": _months.toString(),
          "deadline": _deadline.toString(),
          "user": _email
        },
      );

      if (response.statusCode == 200) {
        print('Dado inserido!');

        showSuccessMessage("$_type inserido com sucesso!");

        setState(() {
          _nameDebt = '';
          _category = 'salario';
          _value = 0.0;
          _months = 0.0;
          _deadline = 0.0;
        });
      } else if (response.statusCode == 400) {
        showSuccessMessage("Valores inseridos estão errados.");
      } else {
        print('Erro ao fazer login: ${response.statusCode}');
        showSuccessMessage("Erro ao inserir. Tente novamente mais tarde.");
      }
    } catch (error) {
      print('Erro ao fazer login: $error');
      showSuccessMessage("Erro ao inserir. Tente novamente mais tarde.");
    }
  }

  void showSuccessMessage(String message) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Fecha o AlertDialog
              Navigator.pop(context); // Navega de volta para o HomeView
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }
}
