import 'package:flutter/material.dart';
import 'package:pac/login/widgets/email.widget.dart';
import 'package:pac/login/widgets/forgetpassword.widget.dart';
import 'package:pac/login/widgets/loginbutton.widget.dart';
import 'package:pac/login/widgets/logo.widget.dart';
import 'package:pac/login/widgets/password.widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
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
            SizedBox(height: 110),
            LogoIcon(),
            SizedBox(height: 100),
            Padding(padding: EdgeInsets.symmetric(horizontal: 40),
            child: EmailField(),
            ),
            SizedBox(height: 10),
            Padding(padding: EdgeInsets.symmetric(horizontal: 40),
            child: PasswordField(),
            ),
            SizedBox(height: 17),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40), 
              child: LoginButtonField(),
            ),
            SizedBox(height: 10),
            ForgetPasswordField(),
          ],    
        ),
      ),
    );
    
  }
}