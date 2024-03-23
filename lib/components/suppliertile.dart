
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SupplierTile extends StatelessWidget {
 final  DocumentSnapshot<Map<String,dynamic>?> snapshot;
  const SupplierTile({super.key,required this.snapshot});
 
  @override
  Widget build(BuildContext context) {
   final  data=snapshot.data();
   
    return ListTile(title: Text(data?['name']));
  }
}