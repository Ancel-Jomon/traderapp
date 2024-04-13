
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/components/ordertileretailer.dart';

class ListOrders {
  Widget allOrders(Stream<QuerySnapshot> stream) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("place a new order"),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot<Map<String, dynamic>?> documentSnapshot =
                      snapshot.data!.docs[index]
                          as DocumentSnapshot<Map<String, dynamic>?>;
                  return Card(
                      child: OrderTileRetailer(snapshot: documentSnapshot));
                },
              );
            } else {
              return const Center(
                child: Text("place a new order"),
              );
            }

          default:
            
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
