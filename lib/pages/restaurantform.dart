import 'dart:io';

import 'package:arsim/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RestauranteForm extends StatefulWidget {
  @override
  _RestauranteFormState createState() => _RestauranteFormState();
}

class _RestauranteFormState extends State<RestauranteForm> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController locationController = TextEditingController(text: "");
  String imageUrl = "";

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageUrl = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD6E2EA),
      appBar: AppBar(
        title: Text('Agregar Restaurante'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 47, 47, 41),
                Color.fromARGB(255, 188, 215, 32)
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                prefixIcon: Icon(Icons.person), // Icono para el campo Nombre
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Descripción',
                prefixIcon:
                    Icon(Icons.description), // Icono para el campo Descripción
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Ubicación',
                prefixIcon:
                    Icon(Icons.location_on), // Icono para el campo Ubicación
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectImage,
              child: const Text("Seleccionar Imagen"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            imageUrl.isNotEmpty
                ? Image.file(
                    File(imageUrl),
                    height: 200,
                  )
                : SizedBox(),
            ElevatedButton(
              onPressed: () async {
                await addRestaurant(nameController.text,
                        descriptionController.text, locationController.text)
                    .then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text("Guardar"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
