import 'package:arsim/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/food.dart';

class FoodDetailsPage extends StatefulWidget {
  final Food food;
  const FoodDetailsPage({super.key, required this.food});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  @override
  Widget build(BuildContext context) {
    List<String> ingredientesList = widget.food.ingredientes.split(', ');

    List<Widget> ingredientesWidgets = ingredientesList.map((ingrediente) {
      return ListTile(
        contentPadding:
            EdgeInsets.symmetric(horizontal: 8), // Ajusta este valor
        leading: Icon(Icons.circle,
            color: Colors.grey[600], size: 10), // Icono de viñeta
        title: Text(
          ingrediente,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          //listView of food details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                children: [
                  //image
                  Image.asset(
                    widget.food.imagenUrl,
                    height: 200,
                  ),

                  const SizedBox(height: 25),

                  //rating
                  Row(
                    children: [
                      //star icon
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),

                      const SizedBox(height: 10),

                      //rating number
                      Text(
                        widget.food.estrellas,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  //food name
                  Text(
                    widget.food.nombre,
                    style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                  ),

                  const SizedBox(height: 25),

                  //description
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    widget.food.descripcion,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      height: 2,
                    ),
                  ),
                  const SizedBox(height: 25),

                  //description

                  Text(
                    "Ingredientes",
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Column(
                    children: ingredientesWidgets,
                  )
                ],
              ),
            ),
          ),

          //price
          Container(
              color: primaryColor,
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  //price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //price
                      Text(
                        "\$" + widget.food.precio,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ))

          //price + quantity + add to cart button
        ],
      ),
    );
  }
}
