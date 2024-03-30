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
          
          return Expanded(
            child: ListView.builder(
              physics:const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:  snapshot.data!.docs.length ,
              itemBuilder: (context, index) {
               
                final DocumentSnapshot<Map<String, dynamic>?> snap =
               snapshot.data!.docs[index] as DocumentSnapshot<Map<String, dynamic>?>;
                return Card(child: OrderProducttile(product: Product.fromFirestore(snap)));
                
              },
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
