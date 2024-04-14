import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/services/firestoreconnectionoptions.dart';
import 'package:traderapp/services/firestoreorderoptions.dart';
import 'package:traderapp/supplierpages/others/loadorderitems.dart';

class OrderTileSupplier extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>?> snapshot;
  final bool options;
  const OrderTileSupplier({super.key, required this.snapshot,required this.options});

  @override
  State<OrderTileSupplier> createState() => _OrderTileSupplierState();
}

class _OrderTileSupplierState extends State<OrderTileSupplier> {
   bool value=false;

  Future<DocumentSnapshot<Map<String, dynamic>>> retailerdetail(
      DocumentSnapshot<Map<String, dynamic>?> documentSnapshot) async {
    final DocumentSnapshot<Map<String, dynamic>> docsnap =
        await FirestoreConnection().collectRetailerInfo(documentSnapshot);

    return docsnap;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.snapshot.data();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder(
                future: retailerdetail(widget.snapshot),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final DocumentSnapshot<Map<String, dynamic>?> snap =
                        snapshot.data!;
                    return Text('ORDER FROM:${snap['name']}',style: const TextStyle(fontSize: 20),);
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
          PerOrderItems(snapshot: widget.snapshot),
          showoptions()
          
        ],
      ),
    );
  }
  Widget showoptions(){
    if(widget.options){
     return Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('delivered'),
              Switch(value: value, onChanged:(value) {
            setState(() {
             this.value = value;
            });
            log('here');
            FireSupOrder().deliverOrder(widget.snapshot);
          },)
            ],
          );
    }
    else{
      return const SizedBox.shrink();
    }
  }
}
