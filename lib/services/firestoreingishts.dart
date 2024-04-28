import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class FirestoreInsights {
  final user = FirebaseAuth.instance.currentUser;
  final orderef = FirebaseFirestore.instance.collection('orders');
  final date = DateTime.now();

  //final data=FieldValue.serverTimestamp();

  void getorderdata(bool options) async {
    final thismonth = DateTime(date.year, date.month, 1);
    Timestamp stamp = Timestamp.fromDate(thismonth);
    log(date.year.toString());
    log(date.month.toString());
    log(date.day.toString());
    log(thismonth.toString());
    log(stamp.toString());
    if (true)
    //if true the from supplier
    {
      final supplier ="/userdetails/${user!.uid}";
      log(supplier);
      final docs = await orderef
          .where('timestamp', isGreaterThan: thismonth)
          .where('supplier_id', isEqualTo: supplier)
          .get();
      final docdata = docs.docs;
      for (var eachdoc in docdata) {
        log(eachdoc.id);
      }
    }
  }
}
