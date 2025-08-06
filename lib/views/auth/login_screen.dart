import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to the Login Screen!'),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                       contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle login logic here
                      print('Login button pressed');
                    },
                    child: Text('Login'),
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
