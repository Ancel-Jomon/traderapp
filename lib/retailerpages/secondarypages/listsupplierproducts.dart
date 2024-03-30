import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/retailerpages/others/loadproduct.dart';
import 'package:traderapp/services/firestoreproductoptions.dart';

class PlaceOrder extends StatefulWidget {
  final String id;
  const PlaceOrder({super.key, required this.id});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  Stream<QuerySnapshot>? stream(id) {
    return FireretProduct().readSupplierProduct(id);
  }

  onPressed() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: const Text("Place Order"),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Products",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 25),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [const LoadProducts().allProducts(stream(widget.id))],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: MyButton(onPressed: onPressed, msg: "place order"),
          )
        ],
      ),
    );
  }
}
