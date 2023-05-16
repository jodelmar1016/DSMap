import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dsmap/authentication/login.dart';
import 'package:dsmap/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService auth = AuthService();
  bool _isLoading = true;
  String name = '';
  String email = '';
  String contact = '';

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('userName')!;
      email = prefs.getString('userEmail')!;
      contact = prefs.getString('userContact')!;
      _isLoading = false;
    });
  }

  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROFILE'),
      ),
      body: Stack(
        children: [
          Center(
            child: Card(
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 50,
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      '${name}',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '${email}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '${contact}',
                      style: TextStyle(fontSize: 20),
                    ),
                    // SizedBox(height: 15),
                    // Text(
                    //   'Gattaran, Cagayan',
                    //   style: TextStyle(fontSize: 20),
                    // ),
                    SizedBox(height: 70),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      child: ElevatedButton(
                        onPressed: () async {
                          await clearPrefs();
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  Login(),
                              transitionDuration: Duration(milliseconds: 500),
                              transitionsBuilder:
                                  (context, animation1, animation2, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset(-1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation1),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Text('Logout'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
