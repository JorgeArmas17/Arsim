import 'package:arsim/components/my_button.dart';
import 'package:arsim/components/my_textfield.dart';
import 'package:arsim/components/square_tile.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controller
  final userNameController  = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
            //logo
            const Icon(Icons.lock,size: 100,),
            
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
              controller:  userNameController,
              hintText: 'Username',
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
            MyButton(
              onTap: signUserIn
            ),

            const SizedBox(height: 50),
  
            //or continue with
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.3,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Or Continue With',
                      style: TextStyle(color: Colors.grey[700]),
                      ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.3,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),

            //google + apple sign in buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //google Button
                SquareTile(imagePath: 'lib/images/google.png'),
                
                SizedBox(width: 25),
                //Apple Button
                SquareTile(imagePath: 'lib/images/apple.png'),
              ],
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member?'),
                const SizedBox(width: 4),
                Text(
                  'Register now',
                  style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold
                  ),
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