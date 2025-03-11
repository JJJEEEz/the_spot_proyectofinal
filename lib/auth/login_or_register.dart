import 'package:flutter/material.dart';
import 'package:the_spot_proyectofinal/Pages/login_page.dart';
import 'package:the_spot_proyectofinal/Pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Iniciamos en la pagina de inicio de sesion
  bool showLoginPage = true;

  // Metodo para cambiar entre la pagina de inicio de sesion y la de registro
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
