import 'package:arsim/components/button.dart';
import 'package:arsim/model/food.dart';
import 'package:arsim/pages/food_details_page.dart';
import 'package:arsim/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import '../components/food_tile.dart';
import '../components/progress_bar.dart';

class PageMenu extends StatefulWidget {
  final int num;
  final String title;
  PageMenu({super.key, required this.num, required this.title});

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

Future<List<Food>> fetchFoodList(int num) async {
  List<dynamic> ID =
      await fetchFoodID(); // Suponiendo que fetchFoodID() retorna Future<List<dynamic>>
  print('datos: ${ID[num]} ');
  List<Food> foodMenu = [];

  //for (dynamic id in ID) {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('registro')
      .doc(ID[num])
      .collection('platos')
      .get();

  for (QueryDocumentSnapshot doc in snapshot.docs) {
    foodMenu.add(
      Food(
        nombre: doc['nombre'] ?? '',
        precio: doc['precio'] ?? '',
        imagenUrl: doc['imagenUrl'] ?? '',
        descripcion: doc['descripcion'],
        ingredientes: doc['ingredientes'] ?? '',
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

  // Estado para controlar el cambio de color del corazón
  bool isHeartPressed = false;

  @override
  Widget build(BuildContext context) {
    int num = widget.num;
    return FutureBuilder<List<Food>>(
      future: fetchFoodList(num),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ProgressBar();
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
                widget.title,
                style: TextStyle(color: Colors.black, fontSize: 18),
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
                            'lib/images/carne.png',
                            height: 60,
                          ),

                          //name andd price

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //name
                              Text(
                                "Te gusto la aplicacion?",
                                style: GoogleFonts.dmSerifDisplay(fontSize: 18),
                              ),

                              const SizedBox(height: 10),

                              //price
                              Text(
                                "Dale me gusta",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Center(
                        child: LikeButton(
                          size: 30,
                        ),
                      )
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
