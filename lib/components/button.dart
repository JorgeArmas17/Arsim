import 'package:flutter/material.dart';

class MyMainButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyMainButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(40)),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text
            Text(
              text,
              style: TextStyle(color: Colors.black),
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
    );
  }
}
