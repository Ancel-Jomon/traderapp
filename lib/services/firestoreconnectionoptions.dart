import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreConnection {
  final user = FirebaseAuth.instance.currentUser;

  final conref = FirebaseFirestore.instance.collection('connections');
  final userref = FirebaseFirestore.instance.collection('userdetails');
  //late final CollectionReference<Map<String, dynamic>> reqref;

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
        //data['uid']=user.id;
        return data;
      } else if (!value && data['role'] == 'supplier') {
        //data['uid']=user.id;
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> receiverequest() {
    final reqref = FirebaseFirestore.instance
        .collection('userdetails')
        .doc(user!.uid)
        .collection('requests');

    return reqref.snapshots();
  }

  Future<bool?> sendrequest(String id, bool value) async {
    final reqref = FirebaseFirestore.instance
        .collection('userdetails')
        .doc(id)
        .collection('requests');

    if (value) {
      //if value = true then connect requst from supplier
      String retailerid = '/userdetails/$id';
      String supplierid = '/userdetails/${user!.uid}';
      return await conref
          .where('retailer_id', isEqualTo: retailerid)
          .where('supplier_id', isEqualTo: supplierid)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          log('connected');
          return true;
        } else {
          await reqref
              .where('retailer_id', isEqualTo: retailerid)
              .where('supplier_id', isEqualTo: supplierid)
              .get()
              .then((value) async {
            if (value.docs.isEmpty) {
              Map<String, dynamic> data = {
                'retailer_id': retailerid,
                'supplier_id': supplierid,
                'fromsupplier': true
              };
              await reqref.doc().set(data);
              return false;
            }
          });

          return false;
        }
      });
    } else {
      String supplierid = '/userdetails/$id';
      String retailerid = '/userdetails/${user!.uid}';
      return await conref
          .where('supplier_id', isEqualTo: supplierid)
          .where('retailer_id', isEqualTo: retailerid)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          return true;
        } else {
          await reqref
              .where('retailer_id', isEqualTo: retailerid)
              .where('supplier_id', isEqualTo: supplierid)
              .get()
              .then((value) async {
            if (value.docs.isEmpty) {
              Map<String, dynamic> data = {
                'retailer_id': retailerid,
                'supplier_id': supplierid,
                'fromsupplier': false
              };
              await reqref.doc().set(data);
              return false;
            }
          });

          return false;
        }
      });
    }
  }
}
