import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUser {
  static createUser(String email, String password){
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }
}
