import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('reports');

class DataService {
  static Stream<QuerySnapshot> readReports() {
    CollectionReference notesItemCollection = _collection;

    return notesItemCollection.snapshots();
  }
}
