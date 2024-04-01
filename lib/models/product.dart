import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String productName;
  final int productPrice;
  final String? id;

  Product({required this.productName, required this.productPrice,this.id});

  Map<String, dynamic> toFirestore() {
    return {
      'name': productName,
      'price': productPrice,
      'id':id
    };
  }

  factory Product.fromFirestore(
   DocumentSnapshot<Map<String, dynamic>?> snapshot,
  ) {
    final id=snapshot.id;
    final data = snapshot.data();
    return Product(productName: data?['name'], productPrice:data?['price'],id: id);
  }
}
