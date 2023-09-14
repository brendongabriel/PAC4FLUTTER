import 'package:flutter/material.dart';

class TermosCheck extends StatefulWidget {
  const TermosCheck({Key? key}) : super(key: key);

  @override
  _TermosCheckState createState() => _TermosCheckState();
}

class _TermosCheckState extends State<TermosCheck> {
  bool _isChecked = false;

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
     return InkWell(
      onTap: _toggleCheckbox, 
      child: Row(
        
        children: [
          Checkbox(
            value: _isChecked, 
            onChanged: (value) {
              setState(() {
                _isChecked = value!;
              });
            },
            activeColor: Color.fromARGB(255, 14, 64, 6),
          ),
           // Espaçamento personalizado entre o Checkbox e o Texto.
          Text(
            'Li e concordo com os termos de uso',
            style: TextStyle(
              fontSize: 12,
              color: _isChecked ? Color.fromARGB(255, 19, 50, 19) : Colors.black, // Mudar a cor do texto quando o Checkbox está marcado.
            ),
          ),
        ],
      ),
    );
  }
}