import 'package:flutter/material.dart';
import 'package:traderapp/outer_pages/login.dart';
import 'package:traderapp/outer_pages/register.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool showLogin=true;
void change(){
  setState(() {
    showLogin=!showLogin;
  });
}

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(changepage: change,);
    }
    return RegisterPage(changepage: change,);
  }
}