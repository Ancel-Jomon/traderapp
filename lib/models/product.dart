import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String productName;
  final int productPrice;

  Product({required this.productName, required this.productPrice});

  Map<String, dynamic> toFirestore() {
    return {
      'name': productName,
      'price': productPrice,
    };
  }

  factory Product.fromFirestore(
   DocumentSnapshot<Map<String, dynamic>?> snapshot,
  ) {
    final data = snapshot.data();
    return Product(productName: data?['name'], productPrice:data?['price']);
  }
}
