import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class FirestoreInsights {
  Future<(double, Map<DateTime, double>)> thismonthorderdata(bool options) async {
    if (options) {
      //if true then from supplier
      return await suppliercalc();
    } else {
      return await retailercalc();
    }
  }

  Future<(double, Map<DateTime, double>)> retailercalc() async {
    final user = FirebaseAuth.instance.currentUser;
    final orderef = FirebaseFirestore.instance.collection('orders');
    final date = DateTime.now();

    double monthlysales = 0;
    final thismonth = DateTime(date.year, date.month, 1, 0, 0, 0);
    final lastweek = DateTime(date.year, date.month, date.day - 7);
    final condition = (date.day == 1 ||
        date.day == 2 ||
        date.day == 3 ||
        date.day == 4 ||
        date.day == 5 ||
        date.day == 6 ||
        date.day == 7);
    final Map<DateTime, double> linegraphdata = {};
    for(var i=7;i>0;i--){
      linegraphdata[DateTime(date.year,date.month,date.day-i)]=0;
    }

    final userid = "/userdetails/${user!.uid}";

    if (condition) {
      final docs = await orderef
          .where('timestamp', isGreaterThan: lastweek)
          .where('retailer_id', isEqualTo: userid)
          .where('delivered', isEqualTo: true)
          .get();
      final docdata = docs.docs;
      for (var eachdoc in docdata) {
        Timestamp stamp = eachdoc['timestamp'];
        DateTime eachdate = stamp.toDate();
              num total=eachdoc['total'];

        try {
          if (eachdate.isAfter(thismonth)) {
            monthlysales = monthlysales + total.toDouble();
          }
          if (eachdate.isBefore(DateTime(date.year, date.month, date.day))) {
            final edate = DateTime(eachdate.year, eachdate.month, eachdate.day);

            if (linegraphdata.containsKey(edate)) {
              linegraphdata[edate] =
                  linegraphdata[edate]! + total.toDouble();
            } else {
              try {
                linegraphdata[edate] = total.toDouble();

              } catch (e) {
                log(e.toString());
              }
            }
          }
        } catch (e) {
          log(e.toString());
        }
      }
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
              num total=eachdoc['total'];

        monthlysales = monthlysales + total.toDouble();
        if (eachdate.isBefore(DateTime(date.year, date.month, date.day))) {
          final edate = DateTime(eachdate.year, eachdate.month, eachdate.day);

          if (linegraphdata.containsKey(eachdate)) {
            linegraphdata[edate] =
                linegraphdata[edate]! + total.toDouble();
          } else {
            linegraphdata[edate] = total.toDouble();
          }
        }
      }
    }
    return (monthlysales, linegraphdata);
  }

  Future<(double, Map<DateTime, double>)> suppliercalc() async {
    final user = FirebaseAuth.instance.currentUser;
    final orderef = FirebaseFirestore.instance.collection('orders');
    final date = DateTime.now();
    double monthlysales = 0;
    final thismonth = DateTime(date.year, date.month, 1, 0, 0, 0);
     final lastweek = DateTime(date.year, date.month, date.day - 7);
    final condition = (date.day == 1 ||
        date.day == 2 ||
        date.day == 3 ||
        date.day == 4 ||
        date.day == 5 ||
        date.day == 6 ||
        date.day == 7);

    final Map<DateTime, double> linegraphdata = {};
     for(var i=7;i>0;i--){
      linegraphdata[DateTime(date.year,date.month,date.day-i)]=0;
    }


    final userid = "/userdetails/${user!.uid}";

    final docs = await orderef
        .where('timestamp', isGreaterThan: thismonth)
        .where('supplier_id', isEqualTo: userid)
        .where('delivered', isEqualTo: true)
        .get();
    final docdata = docs.docs;
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
          num total=eachdoc['total'];

        if (eachdate.isAfter(thismonth)) {
          monthlysales = monthlysales +total.toDouble();
        }
        if (eachdate.isBefore(DateTime(date.year, date.month, date.day))) {
          final edate = DateTime(eachdate.year, eachdate.month, eachdate.day);

          if (linegraphdata.containsKey(edate)) {
            linegraphdata[edate] =
                linegraphdata[edate]! + total.toDouble();
          } else {
            linegraphdata[edate]=total.toDouble();
          }
        }
      }
    }
    else{
    for (var eachdoc in docdata) {
      Timestamp stamp = eachdoc['timestamp'];
      DateTime eachdate = stamp.toDate();
      eachdate = DateTime(eachdate.year, eachdate.month, eachdate.day);
      num total=eachdoc['total'];
      monthlysales = monthlysales + total.toDouble();
      if (eachdate.isBefore(DateTime(date.year, date.month, date.day))) {
        eachdate = DateTime(eachdate.year, eachdate.month, eachdate.day);

        if (linegraphdata.containsKey(eachdate)) {
          linegraphdata[eachdate] =
              linegraphdata[eachdate]! + total.toDouble();
        } else {
         try {
          linegraphdata[eachdate] = total.toDouble() ;
         } catch (e) {
           log(e.toString());
         }
        }
      }
    }
  }
    return (monthlysales, linegraphdata);
  }
}
