import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          stops: [0.0,0.7], // Cores do degradê
        ),
      ),

      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(12),
          children: const [
            
          ],    
        ),
      ),
    );
    
  }
}