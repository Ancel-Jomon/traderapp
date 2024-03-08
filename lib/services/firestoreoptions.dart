import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:traderapp/models/retailer.dart';
import 'package:traderapp/models/supplier.dart';
import 'package:traderapp/models/user.dart';
import 'dart:developer' show log;

class FirestoreAddUser {
  final CollectionReference userdetails =
      FirebaseFirestore.instance.collection('userdetails');

  Future addUserDetail(User user, String? uid) async {
    Map docum;
    if (user is Supplier ) {
      Supplier supplier = user;
      docum=supplier.toFirestore();
      docum['role']=supplier.role;
      await userdetails.doc(uid).set(docum);
    }
   else{
    Retailer retailer= user as Retailer;
   docum =retailer.toFirestore();
   docum['role']=retailer.role;
    await userdetails.doc(uid).set(docum);

   }
    
    
    log('here');
  }
}
