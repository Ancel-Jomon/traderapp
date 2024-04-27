import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/services/firestoreconnectionoptions.dart';

class RequestTile extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>>? snapshot;
  final DocumentSnapshot<Map<String,dynamic>> connectiondata;
  const RequestTile({super.key, required this.snapshot,required this.connectiondata});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = snapshot?.data() ?? {'data':'empaty'};
    final connectiondatamap=connectiondata.data();
    log(data.toString());
    
    return Card(
      child: SizedBox(width: 200,
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [const SizedBox(height: 20,),
            CircleAvatar(radius: 40,
              backgroundImage: (data['imgurl'] != null
                  ? NetworkImage(data['imgurl'])
                  : const AssetImage('lib/assets/man.png') as ImageProvider),
            ),
            Text(data['name']),
            Text(data['company']),
            const SizedBox(height: 20,),
            MyButton(onPressed: () {
              FirestoreConnection().requestoptions(true, connectiondatamap!);
            }, msg: 'accept'),MyButton(onPressed: () {
              FirestoreConnection().requestoptions(false, connectiondatamap!);
            }, msg: 'reject')
          ],
        ),
      ),
    );
  }
}
