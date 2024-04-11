import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/components/deleteordertile.dart';
import 'package:traderapp/services/firestoreorderoptions.dart';

class DeleteOrder{

  deleteorder(BuildContext context,DocumentSnapshot snap){
     showDialog(context: context, builder:(context) =>const DeleteOrderTile(),).then((value ) {
          if (value ?? false) {
            FirestoreOrder().deleteorderitems(snap);
          }
    });
  }
}