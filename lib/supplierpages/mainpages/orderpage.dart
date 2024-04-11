import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/services/firestoreorderoptions.dart';
import 'package:traderapp/supplierpages/others/loadorders.dart';

class OrderPage extends StatelessWidget {
   OrderPage({super.key});

  final  Stream<QuerySnapshot> orderstream= FirestoreOrder().retriveOrdersfor();
  

  @override
  Widget build(BuildContext context) {
    return Column(children: [Expanded(child: ListOrders().allOrders(orderstream),)],);
  }
}