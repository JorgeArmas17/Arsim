import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> addRestaurant(
    String name, String description, String location) async {
  await db.collection("registro").add({
    "nombre": name,
    "descripcion": description,
    "ubicacion": location,
  });
}
