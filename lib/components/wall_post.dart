import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_spot_proyectofinal/components/comment.dart';
import 'package:the_spot_proyectofinal/components/comment_button.dart';
import 'package:the_spot_proyectofinal/components/delete_button.dart';
import 'package:the_spot_proyectofinal/components/like_button.dart';
import 'package:the_spot_proyectofinal/helper/helper_methods.dart';

class LienzoPost extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postId;
  final List<String> likes;

  const LienzoPost({
    super.key,
    required this.message,
    required this.user,
    required this.time,
    required this.postId,
    required this.likes,
  });

  @override
  State<LienzoPost> createState() => _LienzoPostState();
}

class _LienzoPostState extends State<LienzoPost> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  // controlador de texto (comentarios)
  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  // funcion para dar like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    // Obtenemos el documento de firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection("Lienzos").doc(widget.postId);

    if (isLiked) {
      // Si se da like se añade el email del usuario a la lista de likes
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      // Si se quita el like se elimina el email del usuario de la lista de likes
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  // añadir un comentario
  void addComent(String commentText) {
    // Escribimos el comentario a firestore en la colección de comentarios, dentro de la coleccion de userpost
    FirebaseFirestore.instance
        .collection("Lienzos")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentTime": Timestamp.now(),
      "CommentedBy": currentUser.email
    });
  }

  // mostrar un dialogo para añadir un comentario
  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text("Add Comment"),
                content: TextField(
                  controller: _commentTextController,
                  decoration: InputDecoration(hintText: "Write your comment"),
                ),
                actions: [
                  //boton para cancelar
                  TextButton(
                    onPressed: () {
                      //eliminar cuadro de texto
                      Navigator.pop(context);

                      // borrar contenido del controlador
                      _commentTextController.clear();
                    },
                    child: Text("Cancel"),
                  ),

                  //boton para postear el comentario
                  TextButton(
                    onPressed: () {
                      //añadir comentario
                      addComent(_commentTextController.text);
                      // eliminar cuadro de texto
                      Navigator.pop(context);
                      // borrar contenido del controlador
                      _commentTextController.clear();
                    },
                    child: Text("Post"),
                  ),
                ],
            ),
          );
  }

  //Borrar un post
  void deleteLienzo(){
    // Mostrar un dialog box, para confirmar antes de eliminar el lienzo
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Delete Post"),
        content: const Text("Are you sure you want to delete this post?"),
        actions: [
          //Boton para cancelar
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Cancel"),
          ),
          
          //Boton para eliminar
          TextButton(
            onPressed: () async {
              //Borrar el comentario de la firestore
              final commentDocs = await FirebaseFirestore.instance
              .collection("Lienzos")
              .doc(widget.postId)
              .collection("Comments")
              .get(),
              
              //Eliminar el lienzo
;}, 
            child: const Text("Delete"),
          ),
      ],
    ),
      
      ;)
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lienzo
          Row(
            children: [

              //grupo de texto (mensaje + usuario)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // usuario
                  Row(
                    children: [
                      Text(
                        widget.user,
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      Text(" - ", style: TextStyle(color: Colors.grey[400])),
                      Text(widget.time, style: TextStyle(color: Colors.grey[400])),
                    ],
                  ),
                  const SizedBox(height: 10),
              
                  //mensaje
                  Text(widget.message),
                ],
              ),

              //Boton de eliminar
              if (widget.user == currentUser.email)
              DeleteButton(onTap: deletePost)
            ],
          ),

          const SizedBox(height: 20),

          // Botones
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Likes
              Column(children: [
                //boton de like
                LikeButton(isLiked: isLiked, onTap: toggleLike),

                const SizedBox(width: 10),

                //Contador de likes
                Text(
                  widget.likes.length.toString(),
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ]),

              const SizedBox(width: 20),

              // Comentarios
              Column(children: [
                //boton de comentarios
                CommentButton(onTap: showCommentDialog),

                const SizedBox(width: 10),

                //Contador de comentarios
                Text(
                  "0",
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ]),
            ],
          ),

          const SizedBox(height: 20),

          //comentarios debajo del post
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Lienzos")
                  .doc(widget.postId)
                  .collection("Comments")
                  .orderBy("CommentTime", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                // Mostramos el circulo de carga si no hay datos
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  shrinkWrap:
                      true, //para listas dentro de widget, hay que ponerles wrap,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    // obtenemos el comentario
                    final commentData = doc.data() as Map<String, dynamic>;

                    //retornamos el comentario
                    return Comment(
                      text: commentData["CommentText"],
                      user: commentData["CommentedBy"],
                      time: formatDate(commentData["CommentTime"]),
                    );
                  }).toList(),
                );
              })
        ],
      ),
    );
  }
}
