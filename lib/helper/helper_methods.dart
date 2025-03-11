// retornamos la fecha como un string
import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
  // Timestamp es un objeto; vamos a obtenerlo de la firebase
  // para imprimirlo, lo convertimos a string
  DateTime dateTime = timestamp.toDate();

  // año
  String year = dateTime.year.toString();

  //mes
  String month = dateTime.month.toString();

  //dia
  String day = dateTime.day.toString();

  //fomato de fecha:
  String formattedData = "$day/$month/$year";

  return formattedData;
}
