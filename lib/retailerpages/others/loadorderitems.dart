
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traderapp/services/firestoreorderoptions.dart';

class PerOrderItems extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>?> snapshot;
  const PerOrderItems({super.key, required this.snapshot});

  Future<DocumentSnapshot<Map<String, dynamic>>> future(String id) {
    return FirestoreOrder().orderitemdetail(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(flex: 2, child: Text('orderitems')),
            Expanded(
                child: Text(
              'quantity',
              textAlign: TextAlign.end,
            )),
            Expanded(
                child: Text(
              'subtotal',
              textAlign: TextAlign.end,
            )),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data()!['orderitems'].length,
          itemBuilder: (context, index) {
            DocumentReference ref = snapshot.data()!['orderitems'][index];
            final path = ref.path;

            return FutureBuilder(
              future: future(path),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic>? snap = snapshot.data!.data();
                  
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${snap!['name']}',
                        ),
                      ),
                      Expanded(
                          child: Text(
                        '${snap['quantity']}',
                        textAlign: TextAlign.end,
                      )),
                      Expanded(
                          child: Text(
                        '\$${snap['price'] * snap['quantity']}',
                        textAlign: TextAlign.end,
                      )),
                    ],
                  );
                } else {
                  return const Text('');
                }
              },
            );
          },
        ),
      ],
    );
  }
}
