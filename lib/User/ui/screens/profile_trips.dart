import 'package:first_app/User/bloc/bloc_user.dart';
import 'package:first_app/User/model/user.dart';
import 'package:first_app/User/ui/screens/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '../widgets/profile_places_list.dart';
import '../widgets/profile_background.dart';

class ProfileTrips extends StatelessWidget {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*return Container(
      color: Colors.indigo,
    );*/

    userBloc = BlocProvider.of<UserBloc>(context);


    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            print('waiting');
            return CircularProgressIndicator();
          case ConnectionState.active:
            print('active');
            return showProfileData(snapshot);

          case ConnectionState.done:
            print('done');
            return showProfileData(snapshot);
          case ConnectionState.none:
            print('none');
            return CircularProgressIndicator();
          default:
            return null;
        }
      }
    );


  }
  Widget showProfileData( AsyncSnapshot snapshot){
    if(!snapshot.hasData || snapshot.hasError){
      print("no logeado");
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              Text("Usuario no logeado. Haz Login"),
            ],
          ),
        ],
      );
    }else{
      print("logeado");
      var user = User(
        uid: snapshot.data.uid,
        name: snapshot.data.displayName,
        email: snapshot.data.email,
        photoURL: snapshot.data.photoUrl
      );

      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              ProfileHeader(user),
              ProfilePlacesList(user)
            ],
          ),
        ],
      );
    }
  }
}