import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('reports');

class DataService {
  // ADD REPORT
  static Future<Response> addReport({
    required String barangay,
    required String message,
    required DateTime date,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": barangay,
      "position": message,
      "contact_no": date
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
}
