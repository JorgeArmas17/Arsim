import 'package:arsim/components/button.dart';
import 'package:arsim/model/food.dart';
import 'package:arsim/pages/food_details_page.dart';
import 'package:arsim/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/food_tile.dart';

class PageMenu extends StatefulWidget {
  const PageMenu({super.key});

  @override
  State<PageMenu> createState() => _PageMenuState();
}

List id = [];

Future<List> fetchFoodID() async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('registro').get();

  for (QueryDocumentSnapshot doc in snapshot.docs) {
    id.add(doc.reference.id);
  }
  return id;
}

Future<List<Food>> fetchFoodList() async {
  List<dynamic> ID =
      await fetchFoodID(); // Suponiendo que fetchFoodID() retorna Future<List<dynamic>>
  print('datos: ${ID[1]} ');
  List<Food> foodMenu = [];

  //for (dynamic id in ID) {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('registro')
      .doc(ID[1])
      .collection('platos')
      .get();

  for (QueryDocumentSnapshot doc in snapshot.docs) {
    foodMenu.add(
      Food(
        nombre: doc['nombre'] ?? '',
        precio: doc['precio'] ?? '',
        imagenUrl: doc['imagenUrl'] ?? '',
        descripcion: doc['descripcion'] ?? '',
        estrellas: doc['estrellas'] ?? '',
      ),
    );
  }
  //}
  print('menu $foodMenu');
  return foodMenu;
}

class _PageMenuState extends State<PageMenu> {
  Future<void> navigateToFoodDetails(int index, List MenuFood) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsPage(
          food: MenuFood[index], // Use foodItems instead of foodMenu
        ),
      ),
    );
  }

  bool isHeartPressed =
      false; // Estado para controlar el cambio de color del corazón

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Food>>(
      future: fetchFoodList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Food> foodItems = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "Tokyo",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //promo massge
                          Text(
                            'Get 32% Promo',
                            style: GoogleFonts.dmSerifDisplay(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 20),

                          //Redeem button
                          MyMainButton(
                            text: "Redeem",
                            onTap: () {
                              // Navigate to the menu page
                              Navigator.pushNamed(context, '/intropage');
                            },
                          )
                        ],
                      ),

                      //image
                      Image.asset(
                        'lib/images/sushi.png',
                        height: 100,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // menu list
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Food Menu",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Food Items

                const SizedBox(height: 25),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: foodItems.length,
                    itemBuilder: (context, index) => FoodTile(
                      food: foodItems[index],
                      onTap: () => navigateToFoodDetails(index, foodItems),
                    ),
                  ),
                ),

                // popular food
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          //image
                          Image.asset(
                            'lib/images/salmon_sushi.png',
                            height: 60,
                          ),

                          //name andd price

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //name
                              Text(
                                "Salon Sushi",
                                style: GoogleFonts.dmSerifDisplay(fontSize: 18),
                              ),

                              const SizedBox(height: 10),

                              //price
                              Text(
                                "\$21.00",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // Cambia el estado del corazón cuando se toca
                          setState(() {
                            isHeartPressed = !isHeartPressed;
                          });
                        },
                        child: Icon(
                          // Cambia el color y el ícono en función del estado
                          Icons.favorite,
                          color: isHeartPressed ? Colors.red : Colors.grey,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
