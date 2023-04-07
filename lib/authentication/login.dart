import 'package:flutter/material.dart';
import 'package:dsmap/screens/user/home.dart';
import 'package:dsmap/authentication/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    // EMAIL
    Widget email = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.email),
          labelText: 'Email',
          // contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        ),
      ),
    );

    // PASSWORD
    Widget password = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock),
          labelText: 'Password',
          // contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        ),
      ),
    );

    Widget loginButton = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 250,
                  ),
                  Text(
                    'DSMAP',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 70),
                  email,
                  SizedBox(height: 20),
                  password,
                  SizedBox(height: 60),
                  loginButton,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ),
                              );
                            },
                            child: Text(
                              'Register new',
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
