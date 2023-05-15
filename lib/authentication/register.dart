import 'package:dsmap/models/response.dart';
import 'package:flutter/material.dart';
import 'package:dsmap/authentication/login.dart';
import 'package:dsmap/screens/home.dart';
import 'package:dsmap/services/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool passwordObscured = true;
  bool confirmPasswordObscured = true;
  bool _isLoading = false;

  final _fullname = TextEditingController();
  final _email = TextEditingController();
  final _contactNumber = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

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
      controller: _fullname,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person),
        labelText: 'Full Name',
      ),
    );

    // EMAIL
    Widget email = TextFormField(
      controller: _email,
      validator: (value) {
        if (value != null) {
          if (value.contains('@') && value.endsWith('.com')) {
            return null;
          }
          return 'Enter a Valid Email Address';
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
        labelText: 'Email',
      ),
    );

    // MOBILE NUMBER
    Widget mobileNumber = TextFormField(
      controller: _contactNumber,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.phone),
        labelText: 'Mobile Number',
      ),
    );

    // PASSWORD
    Widget password = TextFormField(
      controller: _password,
      obscureText: passwordObscured,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        if (value.trim().length < 8) {
          return 'Password must be at least 8 characters in length';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
        labelText: 'Pasword',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              passwordObscured = !passwordObscured;
            });
          },
          icon: Icon(
            passwordObscured ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
    );

    // CONFIRM PASSWORD
    Widget confirmPassword = TextFormField(
      controller: _confirmPassword,
      obscureText: confirmPasswordObscured,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        if (value.trim().length < 8) {
          return 'Password must be at least 8 characters in length';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
        labelText: 'Confirm Pasword',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              confirmPasswordObscured = !confirmPasswordObscured;
            });
          },
          icon: Icon(
            confirmPasswordObscured ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
    );

    // BUTTON SIGN UP
    Widget signup = SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _isLoading = true;
            });
            Response response = await _auth.registerEmailPassword(
                _fullname.text.trim(),
                _email.text.trim(),
                _contactNumber.text.trim(),
                _password.text.trim());
            setState(() {
              _isLoading = false;
            });
            if (response.code == 500) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(response.message.toString()),
                  );
                },
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Account Created, you can now Login')),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            }
          }
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => Home(),
          //   ),
          // );
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
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // avatar,
                      Image.asset(
                        'assets/logo.png',
                        color: Colors.green[700],
                      ),
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
                if (_isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.grey[200],
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
