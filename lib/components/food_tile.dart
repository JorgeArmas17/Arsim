import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/food.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;
  const FoodTile({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(left: 25),
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            Image.network(
              food.imagenUrl,
              height: 140,
            ),

            //text
            Text(
              food.nombre,
              style: GoogleFonts.dmSerifDisplay(fontSize: 20),
            ),

            //price + rating
            SizedBox(
              width: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //price
                  Text(
                    '\$' + food.precio,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),

                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Text(
                        food.estrellas,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
