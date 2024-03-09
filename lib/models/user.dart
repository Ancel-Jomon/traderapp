import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:traderapp/models/retailer.dart';
import 'package:traderapp/models/supplier.dart';

class MyUser {
  final String name;
  String? company, phno, address;

  MyUser(
      {required this.name,
      required this.company,
      required this.phno,
      required this.address});

 
  factory MyUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    
  ) {
    final data = snapshot.data();
    if (data?['role'] == 'supplier') {
      return Supplier(
          supplierName: data?['name'],
          scompany: data?['company'],
          sphno: data?['phno'],
          saddress: data?['address']);
    } else {
      return Retailer(
          retailername: data?['name'],
          rcompany: data?['company'],
          rphno: data?['phno'],
          raddress: data?['address']);
    }
  }

   Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'company': company,
      'phno': phno,
      'address': address,
    };
  }

}
