import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/services/firestoreconnectionoptions.dart';
import 'package:traderapp/supplierpages/others/loadorderitems.dart';

class OrderTileSupplier extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>?> snapshot;
  const OrderTileSupplier({super.key, required this.snapshot});

  Future<DocumentSnapshot<Map<String, dynamic>>> retailerdetail(
      DocumentSnapshot<Map<String, dynamic>?> documentSnapshot) async {
    final DocumentSnapshot<Map<String, dynamic>> docsnap =
        await FirestoreConnection().collectRetailerInfo(documentSnapshot);

    return docsnap;
  }

  @override
  Widget build(BuildContext context) {
    final data = snapshot.data();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder(
                future: retailerdetail(snapshot),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final DocumentSnapshot<Map<String, dynamic>?> snap =
                        snapshot.data!;
                    return Text('ORDER FROM:${snap['name']}',style: TextStyle(fontSize: 20),);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Text('\$${data?['total'] ?? 0}')
            ],
          ),
          PerOrderItems(snapshot: snapshot)
        ],
      ),
    );
  }
}
