import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:traderapp/models/user.dart';

class FireBaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential> createWithEmailPassword(String email,password) async{
    try{
        UserCredential userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
        return userCredential;
    }
    on FirebaseAuthException catch(e){
      log(e.toString());
      throw Exception(e);
    }

  }

    Future signOut() async {
      await _auth.signOut();
    }

}
