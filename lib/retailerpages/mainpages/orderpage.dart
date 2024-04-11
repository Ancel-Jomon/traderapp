import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/services/firestoreorderoptions.dart';
import 'package:traderapp/retailerpages/others/loadorders.dart';

class RetOrderPage extends StatelessWidget {
  RetOrderPage({super.key});
  final  Stream<QuerySnapshot> orderstream= FirestoreOrder().retriveOrdersforRetailer();

  @override
  Widget build(BuildContext context) {
    return Column(children: [Expanded(child: ListOrders().allOrders(orderstream),)],);
  }
}