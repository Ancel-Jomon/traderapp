import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/components/orderproducttile.dart';
import 'package:traderapp/models/product.dart';

class LoadProducts {
  const LoadProducts();

  Widget allProducts(Stream<QuerySnapshot>? stream) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isNotEmpty) {
            return Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot<Map<String, dynamic>?> snap = snapshot
                      .data!
                      .docs[index] as DocumentSnapshot<Map<String, dynamic>?>;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: Card(
                          child: OrderProducttile(
                              product: Product.fromFirestore(snap))),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Align(alignment: Alignment.bottomCenter,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(height: 100,width: 100,image: AssetImage('lib/assets/out-of-stock.png')),
                  Text('the supplier has no products')
                ],
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
