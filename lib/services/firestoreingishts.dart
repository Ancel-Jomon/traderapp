import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class FirestoreInsights {
  Future<(double, Map<DateTime, int>)> thismonthorderdata(bool options) async {
    log('insights');
    log(options.toString());
    final user = FirebaseAuth.instance.currentUser;
    final orderef = FirebaseFirestore.instance.collection('orders');
    final date = DateTime.now();

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
    final Map<DateTime, int> linegraphdata = {};
    linegraphdata.addEntries({date:10}.entries);

    final userid = "/userdetails/${user!.uid}";

    if (options) {
      log('supplier');
      //if true then from supplier
      if (condition) {
        final docs = await orderef
            .where('timestamp', isGreaterThan: lastweek)
            .where('supplier_id', isEqualTo: userid)
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
              linegraphdata.addEntries({edate:eachdoc['total'] as  int}.entries);
            }
          }
        }
        //log(monthlysales.toString());
        //log(linegraphdata.toString());
      } else {
        final docs = await orderef
            .where('timestamp', isGreaterThan: thismonth)
            .where('supplier_id', isEqualTo: userid)
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
              linegraphdata[eachdate] = eachdoc['total'] as int;
            }
          }
        }
        log(monthlysales.toString());
      }
    } else {
      if (condition) {
        log(userid);
        final docs = await orderef
            .where('timestamp', isGreaterThan: lastweek)
            .where('retailer_id', isEqualTo: userid)
            .where('delivered', isEqualTo: true)
            .get();
        log('after wait');
        final docdata = docs.docs;
        for (var eachdoc in docdata) {
          log(eachdoc.id);
          Timestamp stamp = eachdoc['timestamp'];
          DateTime eachdate = stamp.toDate();

          if (eachdate.isAfter(thismonth)) {
            monthlysales = monthlysales + eachdoc['total'];
            log(monthlysales.toString());
          }
          if (eachdate.isBefore(DateTime(date.year, date.month, date.day))) {
            final edate = DateTime(eachdate.year, eachdate.month, eachdate.day);
            log(edate.toString());

            if (linegraphdata.containsKey(edate)) {
              log('contains');
              linegraphdata[edate] =
                  linegraphdata[edate]! + eachdoc['total'] as int;
            } else {
              log('contains not');
              log(linegraphdata.toString());
              log(eachdoc['total'].toString());
              linegraphdata.addEntries({edate:eachdoc['total'] as  int}.entries);
               log('adter');

              log(linegraphdata.toString());
            }
            log('outsdie');
          }
        }
        log(monthlysales.toString());
        log(linegraphdata.toString());
      } else {
        final docs = await orderef
            .where('timestamp', isGreaterThan: thismonth)
            .where('supplier_id', isEqualTo: userid)
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
