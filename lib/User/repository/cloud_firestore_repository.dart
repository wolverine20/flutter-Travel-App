import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/Place/model/place.dart';
import 'package:first_app/Place/ui/widgets/card_image.dart';
import 'package:first_app/User/model/user.dart';
import 'package:first_app/User/ui/widgets/profile_place.dart';
import 'cloud_firestore_api.dart';

class CloudFirestoreRepository{

  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore( User user) => _cloudFirestoreAPI.updateUserData(user);
  Future<void> updatePlaceDate( Place place) => _cloudFirestoreAPI.updatePlaceDate(place);
  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreAPI.buildMyPlaces(placesListSnapshot);
  List<CardImageWithFabIcon>buildPlaces(List<DocumentSnapshot> placesListSnapshot)=> _cloudFirestoreAPI.buildPlaces(placesListSnapshot);
}