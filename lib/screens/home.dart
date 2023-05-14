import 'package:flutter/material.dart';
import 'package:dsmap/screens/home.dart';
import 'package:dsmap/screens/reportFAW.dart';
import 'package:dsmap/screens/records.dart';
import 'package:dsmap/screens/testRecords.dart';
import 'package:dsmap/screens/map.dart';
import 'package:dsmap/screens/profile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/logo.png',
            width: 150,
            color: Colors.green[700],
          ),
          elevation: 1,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                  icon: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.green[700],
                  )),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportForm(),
                    ),
                  );
                },
                child: CustomCard(
                  icon: Icon(
                    Icons.scanner,
                    color: Colors.white,
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
                      builder: (context) => ReportListScreen(),
                    ),
                  );
                },
                child: CustomCard(
                  icon: Icon(
                    Icons.track_changes,
                    color: Colors.white,
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
                    color: Colors.white,
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
      color: Colors.green[700],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '$title',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
