import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<DocumentReference> addRestaurant(
    String name, String description, String location, String imageUrl) async {
  DocumentReference restaurantRef = await db.collection("registro").add({
    "nombre": name,
    "descripcion": description,
    "ubicacion": location,
    "imagenUrl": imageUrl,
  });
  // Crear subcolección de platos dentro del documento de restaurante
  print(restaurantRef);
  return restaurantRef;
}

Future<void> addDish(String restaurantId, String name, String imageUrl,
    String description, String precio, String ingredientes) async {
  await db.collection("registro/$restaurantId/platos").add({
    "nombre": name,
    "imagenUrl": imageUrl,
    "descripcion": description,
    "precio": precio,
    "ingredientes": ingredientes,
  });
}

Future<List<Map<String, dynamic>>> fetchRestaurants() async {
  QuerySnapshot snapshot = await db.collection("registro").get();
  List<Map<String, dynamic>> restaurantList = [];

  snapshot.docs.forEach((doc) {
    Map<String, dynamic> restaurantData = doc.data() as Map<String, dynamic>;
    restaurantData['id'] = doc.id; // Agrega el ID del documento al mapa
    restaurantList.add(restaurantData);
  });

  return restaurantList;
}

Future<List<Map<String, dynamic>>> getPlatos(String restaurantId) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection("registro/$restaurantId/platos")
      .get();

  List<Map<String, dynamic>> platos = [];

  snapshot.docs.forEach((DocumentSnapshot doc) {
    platos.add(doc.data() as Map<String, dynamic>);
  });

  return platos;
}
// Future<List> getRegister() async {
//   List people = [];
//   CollectionReference collectionReferenceRegister = db.collection("registro");
//   QuerySnapshot queryRegister = await collectionReferenceRegister.get();
//   queryRegister.docs.forEach((document) {
//     people.add(document.data());
//   });
//   return people;
// }

// Future<void> addDish(String name, String imageUrl, String description,
//     String precio, String ingredientes) async {
//   await db.collection("platos").add({
//     "nombre": name,
//     "imagenUrl": imageUrl,
//     "descripcion": description,
//     "precio": precio,
//     "ingredientes": ingredientes,
//   });
// }


// Future<void> addRestaurant(
//     String name, String description, String location, String imageUrl) async {
//   await db.collection("registro").add({
//     "nombre": name,
//     "descripcion": description,
//     "ubicacion": location,
//     "imagenUrl": imageUrl,
//   });
// }
