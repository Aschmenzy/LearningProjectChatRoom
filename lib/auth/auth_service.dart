import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
//instance of firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

//sign in

  Future<UserCredential> singInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//sing up
  Future<UserCredential> singUpWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

//errors
}
