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
  int _currentMonth = DateTime.now().month;
  int _currentYear = DateTime.now().year;

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

  void _removeItem(String id) {
    print(id);
    http
        .delete(
      Uri.parse('https://app-carteira.wnology.io/api/v1/debt/$id'),
    )
        .then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        showSuccessMessage("Linha deletada com sucesso");
        _loadDebts();
      } else {
        print('Falha na solicitação: ${response.statusCode}');
        showSuccessMessage("Erro ao deletar a dívida");
      }
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_left),
                        onPressed: () {
                          _navigateMonth(-1);
                        },
                      ),
                      Container(
                        child: Text(
                          'Total: ${total} reais',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: isTotalNegative
                                ? Colors
                                    .red // Cor do texto se total for negativo
                                : Colors.green[900], // Cor do texto padrão
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_right),
                        onPressed: () {
                          _navigateMonth(1);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                      child: Text(
                    '${_getFormattedPeriod()}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  )),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('Nome')),
                      DataColumn(label: Text('Categoria')),
                      DataColumn(label: Text('Tipo')),
                      DataColumn(label: Text('Valor')),
                      DataColumn(label: Text('Ação')),
                    ],
                    rows: _getRows(),
                    columnSpacing: 16.0,
                    dataRowHeight: 60.0,
                    headingRowHeight: 60.0,
                    dividerThickness: 1.0,
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  List<DataRow> _getRows() {
    // Adapte essa parte conforme a estrutura dos seus dados
    return (items ?? []).map((item) {
      bool isReceita = item['type'] == 'receita';

      return DataRow(cells: [
        DataCell(Center(child: Text(item['name']))),
        DataCell(Center(child: Text(item['category']))),
        DataCell(Center(child: Text(item['type']))),
        DataCell(Center(child: Text(item['value'].toString()))),
        DataCell(
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Chame sua função de remoção aqui, passando o índice ou o item, como preferir
              _removeItem(item['id']);
            },
          ),
        ),
      ]);
    }).toList();
  }

  String _getFormattedPeriod() {
    return '${_getMonthName(_currentMonth)} $_currentYear';
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';
      default:
        return '';
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
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  void _navigateMonth(int change) {
    setState(() {
      _currentMonth += change;
      if (_currentMonth < 1) {
        _currentMonth = 12;
        _currentYear--;
      } else if (_currentMonth > 12) {
        _currentMonth = 1;
        _currentYear++;
      }
      _dataLoaded = false;
    });
    _loadDebts();
  }

  Future<void> _loadDebts() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://app-carteira.wnology.io/api/v1/debt?user=${_email}&year=${_currentYear}&month=${_currentMonth}'),
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
