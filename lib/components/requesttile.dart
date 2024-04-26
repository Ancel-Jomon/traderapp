import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/components/button.dart';

class RequestTile extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>>? snapshot;
  const RequestTile({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? data = snapshot?.data() ?? {'data':'empaty'};
    log(data.toString());
    
    return Card(
      child: SizedBox(width: 200,
        child: Column(
          children: [const SizedBox(height: 20,),
            CircleAvatar(radius: 40,
              backgroundImage: (data!['imgurl'] != null
                  ? NetworkImage(data['imgurl'])
                  : const AssetImage('lib/assets/man.png') as ImageProvider),
            ),
            Text(data['name']),
            Text(data['company']),
            const SizedBox(height: 20,),
            MyButton(onPressed: () {
              
            }, msg: 'accept'),MyButton(onPressed: () {
              
            }, msg: 'reject')
          ],
        ),
      ),
    );
  }
}
