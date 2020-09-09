import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthApi{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSa = await googleSignInAccount.authentication;

    AuthResult authResult = await _auth.signInWithCredential(
      GoogleAuthProvider.getCredential(idToken: gSa.idToken, accessToken: gSa.accessToken)
    );

    FirebaseUser user = await authResult.user;
    return user;
  }

  signOut() async{
    await _auth.signOut().then((onValue) => print("Sesión cerrada"));
    googleSignIn.signOut();
    print("Sesiones cerradas");


  }
}
