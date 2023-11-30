import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pac/registerDebt/registerDebt.view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? _user = ''; // Variável para armazenar o user
  String _email = ''; // Variável para armazenar o e-mail
  Map<String, dynamic>? _userObj; // Usando Map para representar o JSON
  double? total = 0;
  List<dynamic>? items;
  bool _dataLoaded =
      false; // Variável para controlar se os dados já foram carregados

  _loadEmailFromPreferences() async {
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

  @override
  void openRegister() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => RegisterDebt(),
      ),
    )
        .then((_) {
      _loadDebts();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadEmailFromPreferences().then((_) {
      _loadDebts(); // Chama apenas uma vez quando o widget é iniciado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: openRegister,
        child: Icon(Icons.add),
        backgroundColor: Colors.green[900],
      ),
      appBar: AppBar(
        title: const Text('FinanceApp'),
        backgroundColor: Colors.green[900],
      ),
      body: _body(),
    );
  }

  _body() {
    // Verifica se o total é negativo
    bool isTotalNegative = total! < 0;

    return Container(
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
        child: _dataLoaded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Text(
                      'Total: ${total} reais',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isTotalNegative
                            ? Colors.red // Cor do texto se total for negativo
                            : Colors.green[900], // Cor do texto padrão
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items?.length ?? 0,
                      itemBuilder: (context, index) {
                        var item = items![index];
                        bool isReceita = item['type'] == 'receita';

                        return ListTile(
                          title: Center(
                            child: Text(
                              item['name'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Center(
                            child: Text(
                              'Category: ${item['category']}, Type: ${item['type']}, Value: ${item['value']}',
                            ),
                          ),
                          tileColor:
                              isReceita ? Colors.green[100] : Colors.red[100],
                          // Adicione mais informações se necessário
                        );
                      },
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Future<void> _loadDebts() async {
    try {
      print(_email);
      final response = await http.get(
        Uri.parse(
            'https://app-carteira.wnology.io/api/v1/debt?user=${_email}&month=12'),
      );

      // Verificando se a solicitação foi bem-sucedida (código de status 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        setState(() {
          total = data['total'];
          items = data['items'];
          _dataLoaded = true; // Marca os dados como carregados
        });

        // Faça o que precisar com os dados...
      } else {
        // Se a solicitação falhar, imprima o código de status
        print('Falha na solicitação: ${response.statusCode}');
        throw Exception('Erro ao carregar os dados');
      }
    } catch (error) {
      // Trata erros que podem ocorrer durante a requisição
      print('Erro durante a requisição: $error');
      throw Exception('Erro ao carregar os dados');
    }
  }
}
