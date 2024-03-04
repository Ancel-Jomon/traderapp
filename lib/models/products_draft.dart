import 'package:flutter/material.dart';
import 'package:traderapp/models/product.dart';

class ProductsDraft extends ChangeNotifier{
  final List<Product> products = [];

  List<Product> listOfProducts(){
    return products;
  }

  void addProduct(Product product){
        products.add(product);
        notifyListeners();
  }

  void removeProduct(Product product){
    products.add(product);
    notifyListeners();
  }
}
