import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/retailerpages/others/loadorders.dart';
import 'package:traderapp/services/firestoreorderoptions.dart';

class OrderHistoryPage extends StatelessWidget {
  OrderHistoryPage({super.key});
  final Stream<QuerySnapshot> orderstream = FirestoreOrder()
      .retriveOrdersforRetailer(true); //true corresponds to deliverd orders
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('order history'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListOrders(options: false).allOrders(orderstream),
          )
        ],
      ),
    );
  }
}