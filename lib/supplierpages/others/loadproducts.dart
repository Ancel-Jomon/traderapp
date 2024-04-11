import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/components/producttile.dart';
import 'package:traderapp/models/product.dart';

class ListProducts {
  Widget allProducts(Stream<QuerySnapshot>? stream) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return const Text('safe');
            case ConnectionState.active:
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot<Map<String,dynamic>?> documentSnapshot=snapshot.data!.docs[index] as DocumentSnapshot<Map<String,dynamic>?>;
                  return Card(child: ProductTile(product: Product.fromFirestore(documentSnapshot)),);
                },
              );

           
            default:
              return const Center(child:  CircularProgressIndicator());
          }
        }
        return const Center(child:  CircularProgressIndicator());
      },
    );
  }
}
