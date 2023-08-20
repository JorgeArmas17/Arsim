import 'package:arsim/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DishForm extends StatefulWidget {
  @override
  _DishFormState createState() => _DishFormState();
}

class _DishFormState extends State<DishForm> {
  List<dynamic> restauranList = [];

  String selectedRestaurantId = '';
  TextEditingController dishNameController = TextEditingController(text: "");
  TextEditingController dishDescriptionController =
      TextEditingController(text: "");
  TextEditingController dishPriceController = TextEditingController(text: "");
  TextEditingController dishIngredientsController =
      TextEditingController(text: "");
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

  void _resetForm() {
    dishNameController.clear();
    imageUrl = "";
    dishDescriptionController.clear();
    dishPriceController.clear();
    dishIngredientsController.clear();
    selectedRestaurantId = '';
  }

  @override
  void initState() {
    super.initState();
    fetchPeople(); // Llamar a la función para obtener los datos al inicializar
  }

  Future<void> fetchPeople() async {
    List<Map<String, dynamic>> fetchedList = await fetchRestaurants();
    setState(() {
      restauranList = fetchedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _formSubmitted = false;
    return Scaffold(
      backgroundColor: Color(0xffD6E2EA),
      appBar: AppBar(
        title: Text('Agregar Plato'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 47, 47, 41),
                Color.fromARGB(255, 138, 60, 55),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton(
              items: restauranList.map((restaurant) {
                return DropdownMenuItem(
                  value: restaurant[
                      'id'], // Utiliza el ID del documento como valor
                  child: Text(restaurant['nombre']),
                );
              }).toList(),
              onChanged: (selectedRestaurant) {
                setState(() {
                  selectedRestaurantId = selectedRestaurant as String;
                  print(selectedRestaurantId);
                });
              },
              hint: Text('Seleccionar Restaurante'),
            ),
            TextFormField(
              controller: dishNameController,
              decoration: InputDecoration(
                labelText: 'Nombre del Plato',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _selectImage,
              label: Text("Imagen"),
              icon: Icon(Icons.image),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: dishDescriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción del Plato',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: dishPriceController,
              decoration: InputDecoration(
                labelText: 'Precio del Plato',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: dishIngredientsController,
              decoration: InputDecoration(
                labelText: 'Ingredientes del Plato',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                await addDish(
                    selectedRestaurantId,
                    dishNameController.text,
                    imageUrl,
                    dishDescriptionController.text,
                    dishPriceController.text,
                    dishIngredientsController.text);
                setState(() {
                  _formSubmitted = true;
                });
                // Imprimir los datos de los platos después de agregar uno nuevo
                List<Map<String, dynamic>> platos =
                    await getPlatos(selectedRestaurantId);
                print("Platos del restaurante $selectedRestaurantId:");
                platos.forEach((plato) {
                  print("Nombre: ${plato['nombre']}");
                  print("Imagen: ${plato['imagenUrl']}");
                  print("Descripción: ${plato['descripcion']}");
                  print("Precio: ${plato['precio']}");
                  print("Ingredientes: ${plato['ingredientes']}");
                  print("------------------------");
                });
                _resetForm();
              },
              label: Text('Guardar'),
              icon: Icon(Icons.send),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 144, 33, 25),
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
