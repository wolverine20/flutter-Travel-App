import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/Place/model/place.dart';
import 'package:first_app/Place/ui/widgets/card_image.dart';
import 'package:first_app/User/model/user.dart';
import 'package:first_app/User/repository/cloud_firestore_api.dart';
import 'package:first_app/User/repository/cloud_firestore_repository.dart';
import 'package:first_app/User/ui/widgets/profile_place.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:first_app/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Place/repository/firebase_storage_repository.dart';
class UserBloc implements Bloc{

  final _auth_repository = AuthRepository();
  //flujo de datos - Streams
  //Stream - Firebase
  //Stream Controller
  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  //la flecha es lo mismo que hacer un return entre llaves
  Stream<FirebaseUser> get authStatus => streamFirebase;
  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();

  //caso de uso
  //1. SignIn a la aplicacion de google
  Future<FirebaseUser> signIn(){
    return _auth_repository.signInFirebase();
  }
  //2 registrar usuario en la bd de datos

  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);
  Future<void> updatePlaceDate( Place place) => _cloudFirestoreRepository.updatePlaceDate(place);
  //guardo una instancia o copia de la lista de places de la bd de firestore
  Stream<QuerySnapshot> placesListStream = Firestore.instance.collection(CloudFirestoreAPI().PLACES).snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;
  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildMyPlaces(placesListSnapshot);
  List<CardImageWithFabIcon>buildPlaces(List<DocumentSnapshot> placesListSnapshot)=> _cloudFirestoreRepository.buildPlaces(placesListSnapshot);

  Stream<QuerySnapshot> myPlacesListStream(String uid) =>
      Firestore.instance.collection(CloudFirestoreAPI().PLACES)
          .where("userOwner", isEqualTo: Firestore.instance.document("${CloudFirestoreAPI().USERS}/${uid}"))
          .snapshots();
  final _firabaseStorageRepository = FirebaseStorageRepository();
  Future<StorageUploadTask> uploadFile (String path, File image) => _firabaseStorageRepository.uploadFile(path, image);


  //2. signout
  signOut(){
    _auth_repository.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

}