import 'package:flutter/material.dart';
import 'package:dsmap/screens/home.dart';
import 'package:dsmap/screens/records.dart';
import 'package:dsmap/screens/reportFAW.dart';
import 'package:dsmap/screens/map.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/logo.png'),
          title: Text(
            'DISMAP',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    size: 30,
                  )),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportFAW(),
                    ),
                  );
                },
                child: CustomCard(
                  icon: Icon(
                    Icons.scanner,
                    color: Colors.greenAccent,
                    size: 50,
                  ),
                  title: 'Report FAW',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListofRecords(),
                    ),
                  );
                },
                child: CustomCard(
                  icon: Icon(
                    Icons.track_changes,
                    color: Colors.greenAccent,
                    size: 50,
                  ),
                  title: 'List of Records',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: CustomCard(
                  icon: Icon(
                    Icons.info,
                    color: Colors.greenAccent,
                    size: 50,
                  ),
                  title: 'About DISMAP',
                ),
              ),
            ],
          ),
        ));
  }
}

class CustomCard extends StatelessWidget {
  final Icon icon;
  final String title;
  const CustomCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '$title',
                style: TextStyle(fontSize: 30),
              ),
            )
          ],
        ),
      ),
    );
  }
}
