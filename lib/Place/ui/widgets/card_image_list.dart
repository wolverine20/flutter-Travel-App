import 'package:first_app/User/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:first_app/Place/ui/widgets/card_image.dart';


class CardImageList extends StatelessWidget {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {

    double width = 300.0;
    double height = 350;
    double left = 20.0;
    // TODO: implement build
    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      height: 350.0,
      child: StreamBuilder(
          stream: userBloc.placesStream,
          builder: (context, AsyncSnapshot snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return listViewPlaces(userBloc.buildPlaces(snapshot.data.documents));
            case ConnectionState.done:
              return listViewPlaces(userBloc.buildPlaces(snapshot.data.documents));
            case ConnectionState.none:
              return CircularProgressIndicator();
            default:
              return null;
          }
    }
      )
      );


     /* child: ListView(
        padding: EdgeInsets.all(25.0),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CardImageWithFabIcon(
              pathImage: "assets/img/beach_palm.jpeg",
              iconData: Icons.favorite_border,
              width: width,
              height: height,
              left: left
          ),
          CardImageWithFabIcon(
              pathImage: "assets/img/mountain.jpeg",
              iconData: Icons.favorite_border,
              width: width,
              height: height,
              left: left
          ),
          CardImageWithFabIcon(
              pathImage: "assets/img/mountain_stars.jpeg",
              iconData: Icons.favorite_border,
              width: width,
              height: height,
              left: left
          ),
          CardImageWithFabIcon(
              pathImage: "assets/img/river.jpeg",
              iconData: Icons.favorite_border,
              width: width,
              height: height,
              left: left
          ),
          CardImageWithFabIcon(
              pathImage: "assets/img/sunset.jpeg",
              iconData: Icons.favorite_border,
              width: width,
              height: height,
              left: left
          ),
        ],
      ),
    );

      */
  }

  Widget listViewPlaces( List<CardImageWithFabIcon> placesCard){
    return ListView(
      padding: EdgeInsets.all(25.0),
      scrollDirection: Axis.horizontal,
      children: placesCard,
    );
  }
}