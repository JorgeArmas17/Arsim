import 'package:arsim/components/my_button.dart';
import 'package:arsim/components/my_textfield.dart';
import 'package:arsim/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final userNameController = TextEditingController();

  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userNameController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found for that email");
      } else if (e.code == "wrong-password") {
        print("Wrong Password");
      }
      // TODO
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(children: [
            const SizedBox(height: 50),
            //logo
            const Icon(
              Icons.lock,
              size: 100,
            ),

            const SizedBox(height: 50),
            //welcome back, you've been mised
            Text(
              'Welcome back you\'ve been missed',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            //username textfield
            MyTextField(
              controller: userNameController,
              hintText: 'Email',
              obscureText: false,
            ),

            const SizedBox(height: 10),

            //password textfield
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 10),

            //forgot password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            //sign in button
            MyButton(onTap: signUserIn),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member?'),
                const SizedBox(width: 4),
                Text(
                  'Register now',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ],
            )

            //not a member? register now
          ]),
        ),
      ),
    );
  }
}
