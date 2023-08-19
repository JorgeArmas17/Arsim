import 'package:flutter/material.dart';

class DishForm extends StatefulWidget {
  @override
  _DishFormState createState() => _DishFormState();
}

class _DishFormState extends State<DishForm> {
  TextEditingController dishNameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Plato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: dishNameController,
              decoration: InputDecoration(
                labelText: 'Nombre del Plato',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes realizar alguna acción cuando se presione el botón
                String dishName = dishNameController.text;
                // Por ejemplo, puedes mostrar el nombre del plato en un Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Nombre del plato: $dishName')),
                );
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    dishNameController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: DishForm(),
  ));
}
