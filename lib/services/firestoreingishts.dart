import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class FirestoreInsights {
  static Future<(double, Map<DateTime, int>)> thismonthorderdata(
      bool options) async {
    final user = FirebaseAuth.instance.currentUser;
    final orderef = FirebaseFirestore.instance.collection('orders');
    final date = DateTime(2024, 5, 2);

    double monthlysales = 0;
    final thismonth = DateTime(date.year, date.month, 1, 0, 0, 0);
    //log(thismonth.toString());
    final lastweek = DateTime(date.year, date.month, date.day - 7);
    final condition = (date.day == 1 ||
        date.day == 2 ||
        date.day == 3 ||
        date.day == 4 ||
        date.day == 5 ||
        date.day == 6 ||
        date.day == 7);
    Map<DateTime, int> linegraphdata = {};
    final supplier = "/userdetails/${user!.uid}";

    if (options) {
      //if true then from supplier
      if (condition) {
        final docs = await orderef
            .where('timestamp', isGreaterThan: lastweek)
            .where('supplier_id', isEqualTo: supplier)
            .where('delivered', isEqualTo: true)
            .get();
        final docdata = docs.docs;
        for (var eachdoc in docdata) {
          Timestamp stamp = eachdoc['timestamp'];
          DateTime eachdate = stamp.toDate();


          if (eachdate.isAfter(thismonth)) {
            monthlysales = monthlysales + eachdoc['total'];
          }
          if (eachdate.isBefore(DateTime(date.year, date.month, date.day))) {
            final edate = DateTime(eachdate.year, eachdate.month, eachdate.day);

            if (linegraphdata.containsKey(edate)) {
              linegraphdata[edate] =
                  linegraphdata[edate]! + eachdoc['total'] as int;
            } else {
              linegraphdata[edate] = eachdoc['total'];
            }
          }
        }
        log(monthlysales.toString());
        log(linegraphdata.toString());
      } else {
        final docs = await orderef
            .where('timestamp', isGreaterThan: thismonth)
            .where('supplier_id', isEqualTo: supplier)
            .where('delivered', isEqualTo: true)
            .get();
        final docdata = docs.docs;
        for (var eachdoc in docdata) {
          Timestamp stamp = eachdoc['timestamp'];
          DateTime eachdate = stamp.toDate();
          eachdate = DateTime(eachdate.year, eachdate.month, eachdate.day);
          monthlysales = monthlysales + eachdoc['total'];
          if (eachdate.isBefore(DateTime(date.year, date.month, date.day))) {
            eachdate = DateTime(eachdate.year, eachdate.month, eachdate.day);

            if (linegraphdata.containsKey(eachdate)) {
              linegraphdata[eachdate] =
                  linegraphdata[eachdate]! + eachdoc['total'] as int;
            } else {
              linegraphdata[eachdate] = eachdoc['total'];
            }
          }
        }
        log(monthlysales.toString());
      }
    }
    return (monthlysales, linegraphdata);
  }
}
