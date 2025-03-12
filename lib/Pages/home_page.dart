import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_spot_proyectofinal/components/drawer.dart';
import 'package:the_spot_proyectofinal/Pages/profile_page.dart';
import 'package:the_spot_proyectofinal/components/text_field.dart';
import 'package:the_spot_proyectofinal/components/wall_post.dart';
import 'package:the_spot_proyectofinal/helper/helper_methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Usuario
  final currentUser = FirebaseAuth.instance.currentUser!;

  // Controlador de texto
  final textController = TextEditingController();

  // funcion para cerrar sesion
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // funcion para postear un lienzo
  void postLienzo() {
    // Solo postear si el texto no esta vacio
    if (textController.text.isNotEmpty) {
      // guardarlo en la firebase
      FirebaseFirestore.instance.collection("Lienzos").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }
    // limpiar el textfield
    setState(() {
      textController.clear();
    });
  }

  // funcion para ir a la pagina de perfil
  void goToProfilePage() {
    // Quitar el drawer
    Navigator.pop(context);

    // Ir a la pagina de perfil
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Center(
              child: Text(
            "The Spot",
            style: TextStyle(color: Colors.white),
          )),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: MyDrawer(
          onProfileTap: goToProfilePage,
          onSignOutTap: signOut,
        ),
        body: Center(
          child: Column(
            children: [
              // El spot
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Lienzos")
                      .orderBy("TimeStamp", descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // obtener el lienzo
                          final post = snapshot.data!.docs[index];
                          return LienzoPost(
                            message: post['Message'],
                            user: post['userEmail'],
                            postId: post.id,
                            likes: List<String>.from(
                                post['Likes'] ?? []), // ?? [] para evitar null
                            time: formatDate(post['TimeStamp']),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),

              // Postear un lienzo
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: [
                    // texfield
                    Expanded(
                      child: MyTextField(
                        controller: textController,
                        hintText: "Use the spot",
                        obscureText: false,
                      ),
                    ),

                    // boton para postear
                    IconButton(
                        onPressed: postLienzo,
                        icon: Icon(Icons.arrow_upward_sharp))
                  ],
                ),
              ),

              // usuario
              Text(
                "Logged in as: ${currentUser.email!}",
                style: TextStyle(color: Colors.grey[800]),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ));
  }
}
