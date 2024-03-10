import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:traderapp/models/product.dart';

class FirestoreProduct {
  final user = FirebaseAuth.instance.currentUser;

  final docref = FirebaseFirestore.instance.collection('products');

  void addProductInfo(Product product) async {
    final docum = product.toFirestore();
    docum['uid'] = '/userdetails/${user?.uid}';
    await docref.doc().set(docum);
  }

 Stream<QuerySnapshot<Map<String, dynamic>>> readProductInfo() {
    return docref.where('uid',isEqualTo: '/userdetails/${user?.uid}').snapshots();
  }
}
