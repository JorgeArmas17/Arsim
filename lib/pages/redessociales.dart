import 'package:flutter/material.dart';

class SocialMediaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD6E2EA),
      appBar: AppBar(
        title: Text('Redes Sociales'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 47, 47, 41),
                Color.fromARGB(255, 138, 60, 55)
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SocialMediaBox(
                  icon: Icons.facebook,
                  name: 'Facebook',
                ),
                SocialMediaBox(
                  icon: Icons.access_alarm,
                  name: 'Twitter',
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20), // Espacio entre filas
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SocialMediaBox(
                    icon: Icons.account_circle_outlined,
                    name: 'Instagram',
                  ),
                  SocialMediaBox(
                    icon: Icons.email,
                    name: 'Email',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaBox extends StatelessWidget {
  final IconData icon;
  final String name;

  const SocialMediaBox({required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 137, 62, 56),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
