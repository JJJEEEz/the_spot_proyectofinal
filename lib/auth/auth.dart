import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_spot_proyectofinal/Pages/home_page.dart';
import 'package:the_spot_proyectofinal/auth/login_or_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream:
            FirebaseAuth.instance.authStateChanges(), // stream de autenticación
        builder: (context, snapshot) {
          // Si el usuario está logueado (snapshot tiene datos)
          if (snapshot.hasData) {
            return const HomePage();
          }

          // Si el usuario no está logueado (snapshot no tiene datos)
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
