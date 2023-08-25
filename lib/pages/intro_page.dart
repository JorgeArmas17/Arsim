import 'package:arsim/components/button.dart';
import 'package:arsim/components/progress_bar.dart';
import 'package:arsim/pages/menu_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselItem {
  final String title;
  final String imageUrl;
  final String description;
  final String ubicacion;

  CarouselItem({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.ubicacion,
  });
}

Future<List<CarouselItem>> fetchCarouselItems() async {
  List<CarouselItem> items = [];

  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('registro').get();

  for (QueryDocumentSnapshot doc in snapshot.docs) {
    items.add(CarouselItem(
      title: doc['nombre'] ?? '',
      imageUrl: doc['imagenUrl'] ?? '',
      description: doc['descripcion'] ?? '',
      ubicacion: doc['ubicacion'] ?? '',
    ));
  }

  return items;
}

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CarouselItem>>(
      future: fetchCarouselItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ProgressBar();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<CarouselItem> carouselItems = snapshot.data!;
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 139, 187, 231),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  viewportFraction: 1.0,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
                items: carouselItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  CarouselItem item = entry.value;

                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(height: 25),

                            //Número del carrusel
                            Text(
                              'N ${index + 1}',
                              style: TextStyle(
                                fontSize: 1,
                                color: Colors.black87,
                              ),
                            ),

                            //Nombre del Restaurante
                            Text(
                              item.title,
                              style: GoogleFonts.dmSerifDisplay(
                                fontSize: 28,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 25),

                            //Icono
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(item.imageUrl),
                            ),

                            //Descripcion
                            Text(
                              item.description,
                              style: GoogleFonts.dmSerifDisplay(
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 5),

                            //Ubicacion
                            Text(
                              item.ubicacion,
                              style: TextStyle(
                                color: Colors.black,
                                height: 2,
                              ),
                            ),

                            const SizedBox(height: 25),

                            //Boton Inicio

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PageMenu(
                                      num: index,
                                      title: item.title,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(
                                          255, 173, 214, 244), // Celeste claro
                                      Color.fromARGB(
                                          255, 22, 109, 189), // Celeste medio
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Text
                                    Text(
                                      "Comenzar",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),

                                    const SizedBox(height: 10),

                                    //Icon
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),

                            // MyMainButton(
                            //   text: "Get Started",
                            //   onTap: () {
                            //     // Navigate to the menu page
                            //     Navigator.pushNamed(context, '/menupage');
                            //   },
                            // )
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }
}
