import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/User/repository/firebase_auth.dart';

class AuthRepository{
  final _firebaseAuthAPI = FirebaseAuthApi();

  Future<FirebaseUser> signInFirebase() => _firebaseAuthAPI.signIn();

  signOut() => _firebaseAuthAPI.signOut();
  }