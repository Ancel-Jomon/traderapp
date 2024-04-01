
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:traderapp/models/product.dart';

class FirestoreProduct {
  final user = FirebaseAuth.instance.currentUser;

  final conref = FirebaseFirestore.instance.collection('products');
  
  void addProductInfo(Product product) async {
    final docum = product.toFirestore();
    docum['uid'] = '/userdetails/${user?.uid}';
    await conref.doc().set(docum);
  }

 Stream<QuerySnapshot<Map<String, dynamic>>> readProductInfo() {
    return conref.where('uid',isEqualTo: '/userdetails/${user?.uid}').snapshots();
  }
}
 class FireretProduct{
  
  
  final conref = FirebaseFirestore.instance.collection('products');
  Stream<QuerySnapshot<Map<String, dynamic>>> readSupplierProduct(String id) {
    return conref.where('uid',isEqualTo: '/userdetails/$id').snapshots();
  }

 }
