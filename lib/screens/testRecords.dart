import 'package:dsmap/services/dataService.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsmap/screens/map.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportListScreen extends StatefulWidget {
  @override
  _ReportListScreenState createState() => _ReportListScreenState();
}

class _ReportListScreenState extends State<ReportListScreen> {
  bool _isLoading = true;
  String userId = '';

  void getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? temp = await prefs.getString('userId');
    setState(() {
      userId = temp!;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report List'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Mapping()),
                );
              },
              icon: Icon(Icons.map),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          if (_isLoading == false)
            StreamBuilder<QuerySnapshot>(
              stream: DataService.readReports(userId),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final report = snapshot.data!.docs[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.info),
                            title: Text(report['barangay']),
                            subtitle: Text(report['message']),
                            trailing:
                                Text(report['timestamp'].toDate().toString()),
                          ),
                        );
                      },
                    );
                }
              },
            ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
