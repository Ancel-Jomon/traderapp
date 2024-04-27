import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/models/current_userdetails.dart';
import 'package:traderapp/models/retailer.dart';
import 'package:traderapp/models/supplier.dart';
import 'package:traderapp/models/user.dart';

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
  Future<MyUser> readUserInfo(BuildContext context) async {
    final doc = await docref.doc(user?.uid).get();
    final myuser= MyUser.fromFirestore(doc);
    return myuser;
    
  }
}

class FirestoreWriteUser{
 final user = FirebaseAuth.instance.currentUser;
  String imgurl = '';
  Future<String> uploadprofileimage(XFile image) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child(user!.uid)
          
          .child(image.name);

      final task = await ref.putFile(File(image.path));
      switch (task.state) {
        case TaskState.running:
          log('running');
        case TaskState.success:
          imgurl = await ref.getDownloadURL();

        default:
      }
    } catch (e) {
      log(e.toString());
    }
    return imgurl;
  }

  Future<void> deleteprofileimage(String url) async {
    final ref = FirebaseStorage.instance.refFromURL(url);
    log(ref.fullPath);
    return await ref.delete();
  }
 


}


