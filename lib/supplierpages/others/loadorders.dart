import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/components/ordertilesupplier.dart';

class ListOrders {
  final bool options;
  ListOrders({required this.options});
  Widget allOrders(Stream<QuerySnapshot> stream) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            if( snapshot.data!.docs.isEmpty){
              return const Center(child:  Text('you have no orders'));

            }
            else{
              return ListView.builder(itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot<Map<String,dynamic>?> documentSnapshot=snapshot.data!.docs[index] as DocumentSnapshot<Map<String,dynamic>?>;
            return  Card(child: OrderTileSupplier(snapshot: documentSnapshot,options: options,));
          },
        );
            }
            
          default:
          return const Center(child:  CircularProgressIndicator());
        }
      },
    );
  }
}
