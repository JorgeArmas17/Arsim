import 'package:arsim/components/button.dart';
import 'package:arsim/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 130, 60, 55),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 25),
            //Nombre Restaurante
            Text(
              "EL RODELU",
              style:
                  GoogleFonts.dmSerifDisplay(fontSize: 28, color: Colors.white),
            ),

            const SizedBox(height: 25),

            //Icono
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('lib/images/sushiman.png'),
            ),

            //Titulo
            Text(
              "THE TASTE OF ECUATORIAN FOOD",
              style:
                  GoogleFonts.dmSerifDisplay(fontSize: 44, color: Colors.white),
            ),

            const SizedBox(height: 10),

            //Subtitulo
            Text(
              "Taste the most pouplar food from anywhere any time",
              style: TextStyle(
                color: Colors.grey[300],
                height: 2,
              ),
            ),

            const SizedBox(height: 25),

            //Boton Inicio
            MyMainButton(
              text: "Get Started",
              onTap: () {
                //ir a la pagina de menu
                Navigator.pushNamed(context, '/menupage');
              },
            )
          ],
        ),
      ),
    );
  }
}
