import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final String productName;
  final int productPrice;
  final String? id;
  final String? url;

  const Product({required this.productName, required this.productPrice,this.id, this.url});

  Map<String, dynamic> toFirestore() {
    return {
      'name': productName,
      'price': productPrice,
      'id':id,
      'imgurl':url
    };
  }

  factory Product.fromFirestore(
   DocumentSnapshot<Map<String, dynamic>?> snapshot,
  ) {
    final id=snapshot.id;
    final data = snapshot.data();
    final p= Product(productName: data?['name'], productPrice:data?['price'],id: id,url: data?['imgurl']);
   
    return p;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id];

}
