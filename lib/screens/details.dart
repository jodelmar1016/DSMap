import 'package:dsmap/services/dataService.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Details extends StatefulWidget {
  final QueryDocumentSnapshot data;
  const Details({
    super.key,
    required this.data,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  // Update Status
  void updateStatus(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update'),
          // content: Text('Are you sure you want to accept this booking'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    ).then((value) async {
      if (value == true) {
        await DataService.update(widget.data.id);
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Barangay: ${widget.data['barangay']}',
            ),
            SizedBox(height: 10),
            Text(
              'Message: ${widget.data['message']}',
            ),
            SizedBox(height: 10),
            Text(
              'Status: ${widget.data['status']}',
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${DateFormat('MM dd, yyyy').format(widget.data['timestamp'].toDate())}',
            ),
            SizedBox(height: 10),
            if (widget.data['confirmed'] == true)
              ElevatedButton(
                onPressed: () {
                  updateStatus(context);
                },
                child: Text('Update Status'),
              ),
            SizedBox(height: 10),
            Text('Images'),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: widget.data['images'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(widget.data['images'][index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
