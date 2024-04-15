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

    final String retailerloc = data?['retailer_id'];
    final retailerid = retailerloc.substring(13);

    final doc = await userref.doc(retailerid).get();

    return doc;
  }

  //

  Future<Map<String, dynamic>?> searchuser(String id, bool value) async {
    final user = await userref.doc(id).get();
    final data = user.data();

    if (data != null) {
      if (value && data['role'] == 'retailer') {
        //if value is true and role is retailer for searches from supplier
        return data;
      } else if (!value && data['role'] == 'supplier') {
        return data;
      } else {
        return null;
      }
    }
    else {
      return null;
    }
  }
}
