import 'package:first_app/User/model/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String PLACES = "places";

  final Firestore db = Firestore.instance;

  void updateUserData(User user) async{
    DocumentReference ref = db.collection(USERS).document(user.uid);
    return ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavouritePlaces': user.myFavouritePlaces,
      'lastSignIn': DateTime.now()
    });
  }
}