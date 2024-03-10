import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:traderapp/models/current_userdetails.dart';
import 'package:traderapp/models/retailer.dart';
import 'package:traderapp/models/supplier.dart';
import 'package:traderapp/models/user.dart';
import 'dart:developer' show log;

class FirestoreAddUser {
  final CollectionReference userdetails =
      FirebaseFirestore.instance.collection('userdetails');

  Future addUserDetail(MyUser user, String? uid) async {
    Map docum;
    if (user is Supplier) {
      Supplier supplier = user;
      docum = supplier.toFirestore();
      docum['role'] = supplier.role;
      await userdetails.doc(uid).set(docum);
    } else {
      Retailer retailer = user as Retailer;
      docum = retailer.toFirestore();
      docum['role'] = retailer.role;
      await userdetails.doc(uid).set(docum);
    }
  }
}

class FirestoreReadUser {
  final user = FirebaseAuth.instance.currentUser;

  final docref = FirebaseFirestore.instance.collection('userdetails');
  Future<MyUser> readUserInfo() async {
    final doc = await docref.doc(user?.uid).get();
    final myuser= MyUser.fromFirestore(doc);
    loadCurrentUser(myuser);
    return myuser;
    
  }
}

class FirestoreWriteUser{
  final user = FirebaseAuth.instance.currentUser;

  final docref = FirebaseFirestore.instance.collection('userdetails');



}


