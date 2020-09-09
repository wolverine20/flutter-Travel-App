import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/User/model/user.dart';
import 'package:first_app/platzi_trips_cupertino.dart';
import 'package:flutter/material.dart';
import '../../../widgets/gradient_back.dart';
import '../../../widgets/button_green.dart';
import 'package:first_app/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/platzi_trips.dart';

class SignInScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignInScreen();
  }

}
class _SignInScreen extends State<SignInScreen>{

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //paso el ciclo de vida de la aplicacion
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession(){
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        //snapshot contiene nuestro objeto user traido desde firebase
        if(!snapshot.hasData || snapshot.hasError){
          return signInGoogleUI();
        }else{
          return PlatziTripsCupertino();
        }
      }
    );
  }
  Widget signInGoogleUI(){
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack("",null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Welcome \n This is you travel App",
                    style: TextStyle(
                      fontSize: 37.0,
                      fontFamily: "Lato",
                      color: Colors.white,
                      fontWeight:  FontWeight.bold
                    )
              ),
              ButtonGreen(text: 'Login with Gmail',
                onPressed: () {
                  userBloc.signOut();
                  //userBloc.signIn().then((FirebaseUser user) => print("El usuario es ${user.displayName}"));
                  userBloc.signIn().then((FirebaseUser user) {
                    userBloc.updateUserData(User(
                      uid: user.uid,
                      name: user.displayName,
                      email: user.email,
                      photoURL: user.photoUrl
                    ));
                  });
                },
              width: 300.0,
              height: 50.0,
              )
            ]
          )
        ],
      )
    );
  }

}