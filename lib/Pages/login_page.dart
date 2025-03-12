import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_spot_proyectofinal/components/button.dart';
import 'package:the_spot_proyectofinal/components/text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  // Inicio de sesión
  void signIn() async {
    // Añadir un circulo de carga
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    // Intentar iniciar sesión
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);

      // detener el circulo de carga
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // detener el circulo de carga
      Navigator.pop(context);
      // Mostrar error
      displayMassage(e.code);
    }
  }

  // Mostrar error de inicio de sesión
  void displayMassage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //Logo
              Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              // Mensaje de Bienvenida
              Text(
                "Welcome back, you´ve been missed :c",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 25),

              // Textfield de Correo
              MyTextField(
                controller: emailTextController,
                hintText: 'Email:',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // Textfield de Contraseña
              MyTextField(
                controller: passwordTextController,
                hintText: 'Password:',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // Botón de Iniciar Sesión
              MyButton(onTap: signIn, text: 'Sign In'),

              const SizedBox(height: 5),

              // Botón para Registrarse
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Not a member?",
                    style: TextStyle(color: Colors.grey[800])),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Register now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                ),
              ])
            ]),
          ),
        ),
      ),
    );
  }
}
