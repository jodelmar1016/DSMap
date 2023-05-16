import 'package:firebase_auth/firebase_auth.dart';
import 'package:dsmap/models/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('users');
final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  Future<Response> signInEmailPassword(String email, String password) async {
    Response response = new Response();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      User? user = userCredential.user;
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('uid', user!.uid);
      response.code = 200;
      response.message = 'Successfully Login';
      return response;
    } on FirebaseAuthException catch (e) {
      response.code = 500;
      response.message = e.code;
      return response;
    }
  }

  Future<Response> registerEmailPassword(
    String fullname,
    String email,
    String contactnumber,
    String password,
  ) async {
    Response response = new Response();
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email.toString(), password: password.toString());

      User user = userCredential.user!;
      if (user != null) {
        await user.updateDisplayName(fullname.toString());
        await user.reload();
        user = await _auth.currentUser!;

        // ADD ADDITIONAL INFO
        await _collection.doc(user.uid).set({
          'email': email,
          'name': '$fullname',
          'contact': contactnumber,
        });
      }

      response.code = 200;
      response.message = 'Account Created, you can now Login';
      return response;
    } on FirebaseAuthException catch (e) {
      response.code = 500;
      response.message = e.code;
      return response;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
