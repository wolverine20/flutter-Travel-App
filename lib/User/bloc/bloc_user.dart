import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/User/model/user.dart';
import 'package:first_app/User/repository/cloud_firestore_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:first_app/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UserBloc implements Bloc{

  final _auth_repository = AuthRepository();
  //flujo de datos - Streams
  //Stream - Firebase
  //Stream Controller
  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  //la flecha es lo mismo que hacer un return entre llaves
  Stream<FirebaseUser> get authStatus => streamFirebase;


  //caso de uso
  //1. SignIn a la aplicacion de google
  Future<FirebaseUser> signIn(){
    return _auth_repository.signInFirebase();
  }
  //2 registrar usuario en la bd de datos

  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);

  //2. signout
  signOut(){
    _auth_repository.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

}