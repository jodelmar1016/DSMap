import 'package:flutter/material.dart';
import 'package:dsmap/authentication/login.dart';
import 'package:dsmap/screens/user/home.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    // AVATAR
    Widget avatar = CircleAvatar(
      radius: 70,
      backgroundColor: Colors.grey[300],
      child: Icon(
        Icons.camera_alt_outlined,
        size: 70,
      ),
    );
    // FULL NAME
    Widget fullName = TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person),
        labelText: 'Full Name',
      ),
    );
    // EMAIL
    Widget email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
        labelText: 'Email',
      ),
    );
    // MOBILE NUMBER
    Widget mobileNumber = TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.phone),
        labelText: 'Mobile Number',
      ),
    );
    // PASSWORD
    Widget password = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
        labelText: 'Pasword',
      ),
    );
    // CONFIRM PASSWORD
    Widget confirmPassword = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
        labelText: 'Confirm Pasword',
      ),
    );
    // BUTTON SIGN UP
    Widget signup = SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        },
        child: Text(
          'Sign up',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 70, 30, 0),
            child: Column(
              children: [
                avatar,
                SizedBox(height: 30),
                fullName,
                SizedBox(height: 20),
                email,
                SizedBox(height: 20),
                mobileNumber,
                SizedBox(height: 20),
                password,
                SizedBox(height: 20),
                confirmPassword,
                SizedBox(height: 30),
                signup,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: Text('Login'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
