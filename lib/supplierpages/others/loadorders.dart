import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/components/ordertile.dart';

class ListOrders {
  Widget allOrders(Stream<QuerySnapshot> stream) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            return ListView.builder(itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot<Map<String,dynamic>?> documentSnapshot=snapshot.data!.docs[index] as DocumentSnapshot<Map<String,dynamic>?>;
            return  Card(child: OrderTile(snapshot: documentSnapshot));
          },
        );
            
          default:
          return const Center(child:  CircularProgressIndicator());
        }
      },
    );
  }
}
