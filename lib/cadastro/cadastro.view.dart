import 'package:flutter/material.dart';
import 'package:pac/cadastro/widget/button.widget.dart';
import 'package:pac/cadastro/widget/checkbox.widget.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
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
          stops: [0.0,0.7], // Cores do degradê
        ),
      ),

      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(12),
          children: const [
            SizedBox(height:100),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
              'Digite seus dados abaixo para criar sua conta:', 
              style: TextStyle(
              fontSize: 15, 
              fontWeight: FontWeight.normal,
              ), 
              
              ),
            ),
            SizedBox(height: 40),
            Padding(padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  
                  hintText: 'Nome Completo',
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
            ),
            SizedBox(height: 10),
            Padding(padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  
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
            ),
            SizedBox(height: 10),
            Padding(padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
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
            ),
            SizedBox(height: 10),
            Padding(padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
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
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50), 
              child: TermosCheck(),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 110), 
              child: BotaoCadastro(),
            ),
            
            SizedBox(height: 330),
            
          ],    
        ),
      ),
    );
     
  }
}
