import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter0/Utils/SharedPRef.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Constant.dart';

class Auth {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void signUP(String email, String password) {
    firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  void signIN(String email, String password, BuildContext context) {
    firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Navigator.pushNamed(context, '/home'));

    userid = firebaseAuth.currentUser!.uid.toString();
    createShared(firebaseAuth.currentUser!.uid.toString());
  }

  void signOUT() {
    firebaseAuth.signOut();
  }

  void currentUser(BuildContext context) {
    if (firebaseAuth.currentUser != null) {
      Navigator.pushNamed(context, '/home');
    }
  }

  void googleLogin(BuildContext context) async {
    GoogleSignInAccount? gsa = await GoogleSignIn().signIn();

    GoogleSignInAuthentication ga = await gsa!.authentication;

    var careditial = GoogleAuthProvider.credential(
      idToken: ga.idToken,
      accessToken: ga.accessToken,
    );

    firebaseAuth.signInWithCredential(careditial).then((value) =>
        Navigator.pushNamed(context, '/home'));
  }
}
