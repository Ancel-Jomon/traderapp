import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traderapp/models/product.dart';

class FirestoreProduct {
  final user = FirebaseAuth.instance.currentUser;

  final conref = FirebaseFirestore.instance.collection('products');

  void addProductInfo(Product product) async {
    final docum = product.toFirestore();
    docum['uid'] = '/userdetails/${user?.uid}';
    final id = conref.doc();
    docum['id'] = id.path.substring(9);
    await id.set(docum);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readProductInfo() {
    return conref
        .where('uid', isEqualTo: '/userdetails/${user?.uid}')
        .snapshots();
  }

  void deleteProduct(String? id, String? imgurl) async {
    if (imgurl != null && imgurl != '') {
      try {
        await FirebaseStorage.instance.refFromURL(imgurl).delete();
      } on Exception catch (e) {
        // TODO
        log(e.toString());
      }
    }
    await conref.doc(id).delete();
  }
}

class FireretProduct {
  final conref = FirebaseFirestore.instance.collection('products');
  Stream<QuerySnapshot<Map<String, dynamic>>> readSupplierProduct(String id) {
    return conref.where('uid', isEqualTo: '/userdetails/$id').snapshots();
  }
}

class FireStorage {
  final user = FirebaseAuth.instance.currentUser;
  String imgurl = '';
  Future<String> uploadimage(XFile image) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child(user!.uid)
        .child('products')
        .child(image.name);
    try {
     final  task= await ref.putFile(File(image.path));
     switch(task.state){
      case TaskState.running:
            log('running');
      case TaskState.success:
           
        imgurl = await ref.getDownloadURL();
    
      default:
     }

      log(imgurl);
    } catch (e) {
      log(e.toString());
    }
    return imgurl;
  }
}
