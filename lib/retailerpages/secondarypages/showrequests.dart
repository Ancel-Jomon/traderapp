import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traderapp/components/requesttile.dart';
import 'package:traderapp/services/firestoreconnectionoptions.dart';

class ShowRequests extends StatelessWidget {
  const ShowRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('your requests'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: FirestoreConnection().receiverequest(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                   
                    if (snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final connectiondata = snapshot.data!.docs[index];
                          return FutureBuilder(
                            future: FirestoreConnection()
                                .collectSupplierInfo(connectiondata),
                            builder: (context, snapshot) {
                              final data = snapshot.data;
                              if (snapshot.hasData) {
                                return RequestTile(
                                  snapshot: data,
                                  connectiondata: connectiondata,
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          );
                        },
                      );
                    } else {
                      return const Image(
                          height: 100,
                          width: 100,
                          image: AssetImage('lib/assets/connected.png'));
                    }
                  }
                  return const Text('data');
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
