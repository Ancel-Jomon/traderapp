import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/retailerpages/secondarypages/deleteorder.dart';
import 'package:traderapp/retailerpages/secondarypages/updateorders.dart';
import 'package:traderapp/services/firestoreconnectionoptions.dart';
import 'package:traderapp/retailerpages/others/loadorderitems.dart';

class OrderTileRetailer extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>?> snapshot;
  final bool options; //show generate bill or orther options
  const OrderTileRetailer(
      {super.key, required this.snapshot, required this.options});

  @override
  State<OrderTileRetailer> createState() => _OrderTileRetailerState();
}

class _OrderTileRetailerState extends State<OrderTileRetailer> {
  DocumentSnapshot<Map<String, dynamic>>? orderdata;
  bool showitems = false;

  Future<DocumentSnapshot<Map<String, dynamic>>> supplierdetail(
      DocumentSnapshot<Map<String, dynamic>?> documentSnapshot) async {
    final DocumentSnapshot<Map<String, dynamic>> docsnap =
        await FirestoreConnection().collectSupplierInfo(documentSnapshot);

    return docsnap;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.snapshot.data();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: Column(
        children: [
          FutureBuilder(
            future: supplierdetail(widget.snapshot),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                orderdata = snapshot.data!;
                
                return Column(children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ORDER TO:${orderdata!['name']}',
                      style: const TextStyle(fontSize: 20),
                    ),Text('\$${data?['total'] ?? 0}')
                  ],
                ),
                PerOrderItems(snapshot: widget.snapshot, value:widget.options, orderdata: orderdata)],);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          
          showoptions()
        ],
      ),
    );
  }

  Widget showoptions() {
    if (widget.options) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MyButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateOrders(
                          snapshot: widget.snapshot,
                        ),
                      ));
                },
                msg: "update"),
            const SizedBox(
              width: 10,
            ),
            MyButton(
                onPressed: () {
                  DeleteOrder().deleteorder(context, widget.snapshot);
                },
                msg: "delete")
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
