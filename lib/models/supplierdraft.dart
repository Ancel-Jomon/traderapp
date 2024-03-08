import 'package:flutter/material.dart';
import 'package:traderapp/models/supplier.dart';

class SupplierDraft extends ChangeNotifier{
  final List<Supplier>suppliers = [];

  List<Supplier> listOfSuppliers(){
    return suppliers;
  }

  void addSupplier(Supplier supplier){
        suppliers.add(supplier);
        notifyListeners();
  }

  void removeSupplier(Supplier supplier){
    suppliers.add(supplier);
    notifyListeners();
  }
}
