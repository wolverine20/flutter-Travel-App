import 'package:flutter/material.dart';
import 'review.dart';

class ReviewList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String pathImage ="assets/img/image_viaje.jpg";
    String name = "pablo aranda";
    String details = "1 review 5 photos";
    String comment = "There is an amazing place in Sri Lanka";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Review(pathImage, name,details,comment),
        new Review(pathImage, name,details,comment),
        new Review(pathImage, name,details,comment),
        new Review(pathImage, name,details,comment),
        new Review(pathImage, name,details,comment),
      ],
    );
  }

}