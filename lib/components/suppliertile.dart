import 'package:flutter/material.dart';
import 'package:traderapp/models/supplier.dart';

class SupplierTile extends StatelessWidget {
 final Supplier supplier;
  const SupplierTile({super.key,required this.supplier});
 
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(supplier.supplierName));
  }
}