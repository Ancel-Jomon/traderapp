import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:traderapp/models/user.dart';

class Supplier extends MyUser {
  String supplierName;
  String scompany, sphno, saddress;
  String? simgurl;

  String role = "supplier";

  Supplier(
      {required this.supplierName,
      required this.scompany,
      required this.sphno,
      required this.saddress,this.simgurl})
      : super(
            name: supplierName,
            company: scompany,
            phno: sphno,
            address: saddress,
            imgurl: simgurl
            );

  factory Supplier.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>?> snapshot,
  ) {
    final data = snapshot.data();
    return Supplier(
        supplierName: data?['name'],
        saddress: data?['address'],
        scompany: data?['company'],
        sphno: data?['phno'],
        simgurl: data?['imgurl']);
  }

  @override
  Map<String,dynamic> toFirestore(){
    return {
      'name': name,
      'company': company,
      'phno': phno,
      'address': address,
      'role':role,
      'imgurl':imgurl
    };
  }
}
