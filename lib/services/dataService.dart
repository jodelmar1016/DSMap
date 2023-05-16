import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dsmap/services/request.dart';
import '../models/response.dart';
import 'package:intl/intl.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('reports');

class DataService {
  // ADD REPORT
  static Future<Response> addReport({
    required String barangay,
    required String message,
    required List<File> imageList,
    required LatLng pinLocation,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc();

    List<String> imageURLs = [];

    // Upload each image to Firebase Storage
    for (File imageFile in imageList) {
      final Reference ref = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().toString()}');
      final UploadTask uploadTask = ref.putFile(imageFile);
      final TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() {}));
      final String url = (await downloadUrl.ref.getDownloadURL());
      imageURLs.add(url);
    }

    Map<String, dynamic> data = <String, dynamic>{
      'pin_location': GeoPoint(pinLocation.latitude, pinLocation.longitude),
      'barangay': barangay,
      'message': message,
      'images': imageURLs,
      'timestamp': FieldValue.serverTimestamp(),
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  // GET ALL REPORTS
  static Stream<QuerySnapshot> readReports() {
    CollectionReference notesItemCollection = _collection;

    return notesItemCollection.snapshots();
  }

  // This is for Map
  static Future<Set<Marker>> getAllReports() async {
    Set<Marker> markers = Set();
    QuerySnapshot snapshot = await _collection.get();

    snapshot.docs.forEach((DocumentSnapshot doc) {
      markers.add(
        Marker(
          markerId: MarkerId(doc['pin_location'].toString()),
          position: LatLng(
              doc['pin_location'].latitude, doc['pin_location'].longitude),
          infoWindow: InfoWindow(
            title: '${doc['barangay']}',
            snippet:
                '${DateFormat('MMM dd, yyyy').format(doc['timestamp'].toDate())}',
          ),
        ),
      );
    });

    return markers;
  }
}
