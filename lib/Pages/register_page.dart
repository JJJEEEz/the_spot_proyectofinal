import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_spot_proyectofinal/components/button.dart';
import 'package:the_spot_proyectofinal/components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmpasswordTextController = TextEditingController();

  // registro de usuario
  void signUp() async {
    // Añadir un circulo de carga
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Verificar que las contraseñas coincidan
    if (passwordTextController.text != confirmpasswordTextController.text) {
      // detener el circulo de carga
      Navigator.pop(context);

      // Mostrar error
      displayMassage("Passwords do not match");
      return;
    }

    // Intentar registrar usuario
    try {
      // crea al usuario
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailTextController.text,
              password: passwordTextController.text);

      //despues de crear un usuario, crear un nuevo documento en firestore llamado Users
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'Username': emailTextController.text
            .split('@')[0], //nombre de usuario predeterminado
        'bio': 'Edit your bio', //biografia predeterminada
        'uid': userCredential.user!.uid,
        //se pueden añadir más campos
      });

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
              Text("Lets crate an account!"),
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
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // Textfield de Confirmar Contraseña
              MyTextField(
                controller: confirmpasswordTextController,
                hintText: 'Confirm Password:',
                obscureText: true,
              ),

              const SizedBox(height: 10),
              // Botón para registrarse
              MyButton(onTap: signUp, text: 'Sign Up'),

              const SizedBox(height: 5),
              // Botón para Registrarse
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Already have an account?",
                    style: TextStyle(color: Colors.grey[800])),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Login now",
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
