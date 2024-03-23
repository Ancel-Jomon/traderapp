import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:traderapp/models/user.dart';

class Retailer extends MyUser {
  String retailername;
  String rcompany, rphno, raddress;

  String role = "retailer";

  Retailer(
      {required this.retailername,
      required this.rcompany,
      required this.rphno,
      required this.raddress})
      : super(
            name: retailername,
            company: rcompany,
            phno: rphno,
            address: raddress);

  factory Retailer.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>?> snapshot,
  ) {
    final data = snapshot.data();
    return Retailer(
        retailername: data?['name'],
        raddress: data?['address'],
        rcompany: data?['company'],
        rphno: data?['phno']);
  }
}
