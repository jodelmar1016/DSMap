import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dsmap/authentication/login.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROFILE'),
      ),
      body: Center(
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                  'Fernandez, Aljon B.',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Text(
                  'aljon.official24@gmail.com',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 15),
                Text(
                  '09993133452',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 15),
                Text(
                  'Gattaran, Cagayan',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 70),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
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
    );
  }
}
