import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SupplierTile extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>?> snapshot;
  const SupplierTile({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final data = snapshot.data();
    
    return  Row(
      children: [
         CircleAvatar(
          radius: 40,
          backgroundImage: (data!['imgurl'] != null ? NetworkImage(data['imgurl']) : AssetImage('/lib/assets/man.png')) as ImageProvider,
        ),
        const SizedBox(width: 20,),
        Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${data['name']}',style: const TextStyle(fontSize: 20),),
            Text('Shop: ${data['company']}',style: const TextStyle(fontSize: 20),)
          ],
        )
      ],
    );
  }
}
