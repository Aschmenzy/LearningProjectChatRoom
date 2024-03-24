// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:chat_room_learning/auth/auth_service.dart';
import 'package:chat_room_learning/components/my_button.dart';
import 'package:chat_room_learning/components/my_textField.dart';

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  //email and passwd text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final void Function() onTap;

  RegisterPage({super.key, required this.onTap});

  //login function
  void register(BuildContext context) {
    final authService = AuthService();

    try {
      if (_passwordController.text == _passwordController2.text) {
        authService.singUpWithEmailPassword(
            _emailController.text, _passwordController.text);
      } else {
        // Show dialog for password mismatch
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Passwords don't match!"),
          ),
        );
      }
    } catch (e) {
      // Show dialog for other errors
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.chat,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(
              height: 50,
            ),

            //welcome message

            Text("Let's create an accout for you",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16)),

            const SizedBox(
              height: 25,
            ),

            //email textfield

            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(
              height: 10,
            ),

            //password textfield
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),

            const SizedBox(
              height: 10,
            ),

            //confir password textfield
            MyTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _passwordController2,
            ),

            const SizedBox(
              height: 25,
            ),

            //login button
            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),

            const SizedBox(
              height: 50,
            ),

            //register button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a member? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login now!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
