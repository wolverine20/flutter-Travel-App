import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/Place/model/place.dart';
import 'package:first_app/Place/ui/widgets/card_image.dart';
import 'package:first_app/Place/ui/widgets/title_input_location.dart';
import 'package:first_app/User/bloc/bloc_user.dart';
import 'package:first_app/widgets/button_purple.dart';
import 'package:first_app/widgets/gradient_back.dart';
import 'package:first_app/widgets/text_input.dart';
import 'package:first_app/widgets/title_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

// ignore: must_be_immutable
class AddPlaceScreen extends StatefulWidget{

  File image;

  AddPlaceScreen({
      Key key,
      this.image
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPlaceScreen();
  }
}
class _AddPlaceScreen extends State<AddPlaceScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final _controllerTitlePlace = TextEditingController();
    final _controllerDescriptionPlace = TextEditingController();
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
   return Scaffold(
     body: Stack(
       children: <Widget>[
         GradientBack(height: 300),
         Row(
           // app bar
           children:  <Widget>[
             Container(
               padding: EdgeInsets.only(top:25.0,left:5.0),
               child: SizedBox(
                 height: 45.0,
                 width: 45.0,
                 child: IconButton(
                   icon: Icon(Icons.keyboard_arrow_left, color: Colors.white , size:45),
                   //para volver a la pantalla anterior
                   // se hace un navigator pop porque las pantallas de navegacion van apilandose en una pila
                   onPressed: (){
                     Navigator.pop(context);
                   },
                 )
               )
             ),
            Flexible(
              child: Container(
               padding: EdgeInsets.only(top:45.0 , left: 20.0,right: 10.0),
               child: TitleHeader( title: "Add a new Place"),
             )
            )
           ],
         ),
         Container(
           margin: EdgeInsets.only(top:120.0, bottom: 20.0),
           child: ListView(
             children: <Widget>[
               //foto
               Container(
                 alignment: Alignment.center,
                 child: CardImageWithFabIcon(
                    // pathImage:"assets/img/beach_palm.jpeg",
                     pathImage: widget.image.path,
                     iconData: Icons.camera_alt,
                     width:  350,
                     height:250,
                      left: 0
                 )
               ),
               //texfield titulo
               Container(
                 margin: EdgeInsets.only(top:20.0,bottom: 20.0),
                 child: TextInput(
                   hintText: "Title",
                   inputType: null,
                   maxLines: 1,
                   controller: _controllerTitlePlace,
                 )
               ),
               TextInput(
                 //Description
                 hintText: "Description",
                 inputType: TextInputType.multiline,
                 maxLines: 4,
                 controller: _controllerDescriptionPlace,
               ),
               Container(
                 margin: EdgeInsets.only(top:20.0),
                 child: TitleInputLocation(
                   hintText: "Add Location",
                   iconData: Icons.location_on,
                 )
               ),
               Container(
                 width: 70.0,
                 child: ButtonPurple(
                   buttonText: "Add Place",
                   onPressed: (){

                     //url de la imagen devuelta por el firebase

                     //obtener el id del usuario que esta logeado
                      userBloc.currentUser.then((FirebaseUser user){
                        if(user != null){
                          //firebase storage subir imagen
                          String uid = user.uid;
                          String path = "${uid}/${DateTime.now().toString}.jpg";
                          userBloc.uploadFile(path, widget.image)
                              .then((StorageUploadTask storageUploadTask){
                              storageUploadTask.onComplete.then((StorageTaskSnapshot snapshot){
                                snapshot.ref.getDownloadURL().then((urlImage){
                                  print("URLIMAGE: ${urlImage}");

                                  //usamos cloud firestore
                                  //mostramos el place, titulo , descripcion y titulo de la imagen, user owner, likes
                                  userBloc.updatePlaceDate(Place(
                                    name: _controllerTitlePlace.text,
                                    description: _controllerDescriptionPlace.text,
                                    urlImage: urlImage,
                                    likes: 0,
                                  )).whenComplete(() {
                                    print("Termino");
                                    Navigator.pop(context);
                                  });
                                });
                              });
                           });
                        }
                      });

                   },
                 )
               )
             ],
           )
         )
       ],
     )
   );
  }

}