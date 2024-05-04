import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String productName;
  final num productPrice;
  final String? id;
  final String? url;
  final String availability;
  final String? description;

  const Product(
      {required this.productName,
      required this.productPrice,
      this.id,
      this.url,
      required this.availability,
      this.description});

  Map<String, dynamic> toFirestore() {
    return {
      'name': productName,
      'price': productPrice,
      'id': id,
      'imgurl': url,
      'availability': availability
    };
  }

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>?> snapshot,
  ) {
    final id = snapshot.id;
    final data = snapshot.data();
    final p = Product(
        productName: data?['name'],
        productPrice: data?['price'],
        id: id,
        url: data?['imgurl'],
        availability: data?['availability'] ?? 'Not Available',
        description: data?['description']);

    return p;
  }

  @override
  List<Object?> get props => [id];
}
