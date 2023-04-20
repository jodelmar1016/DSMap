import 'package:firebase_auth/firebase_auth.dart';
import 'package:dsmap/models/response.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Response> signInEmailPassword(String email, String password) async {
    Response response = new Response();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
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

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
