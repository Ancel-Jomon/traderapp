import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:traderapp/models/user.dart';

class Retailer extends MyUser {
  String retailername;
  String rcompany, rphno, raddress;
 String? rimgurl;

  String role = "retailer";

  Retailer(
      {required this.retailername,
      required this.rcompany,
      required this.rphno,
      required this.raddress,this.rimgurl})
      : super(
            name: retailername,
            company: rcompany,
            phno: rphno,
            address: raddress,imgurl: rimgurl);

  factory Retailer.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>?> snapshot,
  ) {
    final data = snapshot.data();
    return Retailer(
        retailername: data?['name'],
        raddress: data?['address'],
        rcompany: data?['company'],
        rphno: data?['phno'],
        rimgurl: data?['imgurl']);
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
