
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/components/suppliertile.dart';
import 'package:traderapp/retailerpages/secondarypages/placeorders.dart';
import 'package:traderapp/services/firestoreconnectionoptions.dart';

class ListSuppliers {
  Future<DocumentSnapshot<Map<String, dynamic>>> suppliertiledetail(
      DocumentSnapshot<Map<String, dynamic>?> documentSnapshot) async {
    final DocumentSnapshot<Map<String, dynamic>> docsnap =
        await FirestoreConnection().collectSupplierInfo(documentSnapshot);

    return docsnap;
  }

  Widget allSuppliers(Stream<QuerySnapshot>? stream) {
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
                  DocumentSnapshot<Map<String, dynamic>?> documentSnapshot =
                      snapshot.data!.docs[index]
                          as DocumentSnapshot<Map<String, dynamic>?>;

                  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: suppliertiledetail(documentSnapshot),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final DocumentSnapshot<Map<String, dynamic>?> snap =
                            snapshot.data!;
                            
                        final data =snap.id;
                        return Card(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                             PlaceOrder(id: data,),
                                      ));
                                },
                                child: SizedBox(
                                    height: 100,
                                    child: SupplierTile(snapshot: snap))));
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  );
                  
                },
              );

            case ConnectionState.waiting:
              return const CircularProgressIndicator(
                color: Colors.black,
              );
            default:
              return const CircularProgressIndicator();
          }
        }
        return const Text('error lol');
      },
    );
  }
}
