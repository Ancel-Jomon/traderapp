
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreConnection {
  final user = FirebaseAuth.instance.currentUser;

  final conref = FirebaseFirestore.instance.collection('connections');
  final userref = FirebaseFirestore.instance.collection('userdetails');

  Stream<QuerySnapshot<Map<String, dynamic>>> readSupplierList() {
    final data = conref
        .where('retailer_id', isEqualTo: '/userdetails/${user?.uid}')
        .snapshots();

    return data;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> collectSupplierInfo(
      DocumentSnapshot<Map<String, dynamic>?> snapshot) async {
    final data = snapshot.data();

    final String supplierloc = data?['supplier_id'];
    final supplierid = supplierloc.substring(13);

    final doc = await userref.doc(supplierid).get();

    return doc;
  }
  Future<DocumentSnapshot<Map<String, dynamic>>> collectRetailerInfo(
      DocumentSnapshot<Map<String, dynamic>?> snapshot) async {
    final data = snapshot.data();

    final String retailerloc = data?['retailerid'];
    final retailerid = retailerloc.substring(13);

    final doc = await userref.doc(retailerid).get();

    return doc;
  }
}
