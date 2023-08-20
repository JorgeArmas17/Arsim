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

  CarouselItem({
    required this.title,
    required this.imageUrl,
    required this.description,
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
            backgroundColor: Color.fromARGB(255, 130, 60, 55),
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
                              'Restaurante ${index + 1}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            //Nombre del Restaurante
                            Text(
                              item.title,
                              style: GoogleFonts.dmSerifDisplay(
                                fontSize: 28,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 25),
                            //Icono
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(item.imageUrl),
                            ),
                            //Titulo
                            Text(
                              "THE TASTE OF ECUATORIAN FOOD",
                              style: GoogleFonts.dmSerifDisplay(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            //Subtitulo
                            Text(
                              item.description,
                              style: TextStyle(
                                color: Colors.grey[300],
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
                                          )),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(109, 140, 94, 91),
                                    borderRadius: BorderRadius.circular(40)),
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Text
                                    Text(
                                      "Get Started",
                                      style: TextStyle(color: Colors.white),
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
