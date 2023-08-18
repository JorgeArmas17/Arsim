import 'package:arsim/components/button.dart';
import 'package:arsim/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselItem {
  final String title;
  final String imageUrl;
  final String description;

  CarouselItem(
      {required this.title, required this.imageUrl, required this.description});
}

List<CarouselItem> carouselItems = [
  CarouselItem(
    title: 'EL RODELU',
    imageUrl: 'lib/images/sushiman.png',
    description: 'Taste the most popular food from anywhere any time',
  ),
  CarouselItem(
    title: 'DORILOKO',
    imageUrl: 'lib/images/carne.png',
    description: 'Tas',
  ),
  // Agrega más elementos del carrusel según tus necesidades
];

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          items: carouselItems.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 25),
                      Text(
                        item.title,
                        style: GoogleFonts.dmSerifDisplay(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(item.imageUrl),
                      ),
                      Text(
                        "THE TASTE OF ECUATORIAN FOOD",
                        style: GoogleFonts.dmSerifDisplay(
                          fontSize: 44,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item.description,
                        style: TextStyle(
                          color: Colors.grey[300],
                          height: 2,
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyMainButton(
                        text: "Get Started",
                        onTap: () {
                          // Navigate to the menu page
                          Navigator.pushNamed(context, '/menupage');
                        },
                      ),
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
}
