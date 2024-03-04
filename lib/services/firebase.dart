

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:traderapp/models/user.dart';

class FirestoreAddUser{


  final CollectionReference userdetails =FirebaseFirestore.instance.collection('userdetails');

  Future addUserDetail(User user){
    return userdetails.add({
      'name':user.name
    });
    
  }
}