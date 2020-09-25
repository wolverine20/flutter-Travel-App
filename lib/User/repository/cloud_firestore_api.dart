import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Place/model/place.dart';
import 'package:first_app/Place/ui/widgets/card_image.dart';
import 'package:first_app/Place/ui/widgets/card_image_list.dart';
import 'package:first_app/User/model/user.dart';
import 'package:first_app/User/ui/widgets/profile_place.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String PLACES = "places";

  final Firestore db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(User user) async{
    DocumentReference ref = db.collection(USERS).document(user.uid);
    return  await ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavouritePlaces': user.myFavouritePlaces,
      'lastSignIn': DateTime.now()
    });
  }
  Future<void> updatePlaceDate( Place place) async{
    //vamos a delegar a firestore que cree el identificador del documento a diferencia de user
    CollectionReference refPlaces = db.collection(PLACES);
    //await para que se ejecute en segundo plano
    await _auth.currentUser().then((FirebaseUser user){
      refPlaces.add({
        'name': place.name,
        'description': place.description,
        'like': place.likes,
        'urlImage': place.urlImage,
        'userOwner': db.document("${USERS}/${user.uid}") //reference
        }
      ).then((DocumentReference dr){
        dr.get().then((DocumentSnapshot snapshot){
          snapshot.documentID;//ID del place referencia array
          DocumentReference refUsers = db.collection(USERS).document(user.uid);
          refUsers.updateData({
            'myPlaces' : FieldValue.arrayUnion([ db.document("${PLACES}/${snapshot.documentID}")])
          });
        });
      });
    });
  }


  //para devolver todo el procesamiento de datos del snapshot

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot){
    List<ProfilePlace>  profilePlaces = List<ProfilePlace>();
    placesListSnapshot.forEach((p) {
      profilePlaces.add(ProfilePlace(
        Place(
          name: p.data['name'],
          description: p.data['description'],
          urlImage: p.data['urlImage'],
          likes: p.data['likes']
        )
      ));
    });
    return profilePlaces;


  }

  List<CardImageWithFabIcon>buildPlaces(List<DocumentSnapshot> placesListSnapshot){
      List<CardImageWithFabIcon> placesCard = List<CardImageWithFabIcon>();
      placesListSnapshot.forEach((p) {
          double width = 300.0;
          double height = 350.0;
          double left = 20.0;
          IconData iconData = Icons.favorite_border;

          placesCard.add(
            CardImageWithFabIcon(
              pathImage: p.data["urlImage"],
              width: width,
              height: height,
              onPressedFabIcon: (){

              },
              iconData: iconData,
            )
          );
      });
      return placesCard;
  }
}