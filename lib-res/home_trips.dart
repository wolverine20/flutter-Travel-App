import 'file:///D:/proyectos/react/first_app/lib/Place/ui/widgets/review_list.dart';
import 'package:flutter/material.dart';

import 'description_place.dart';
import 'header_appbar.dart';

class HomeTrips extends StatelessWidget{
  String descriptionDummy = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        ListView(
          children: [
            DescriptionPlace('Bahamas',4,descriptionDummy),
            ReviewList()
          ],
        ),
        HeaderAppBar()
      ],
    );
  }

}