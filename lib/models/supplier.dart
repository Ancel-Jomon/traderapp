import 'package:traderapp/models/user.dart';

class Supplier extends User{
  String supplierName;
  
  Supplier({required this.supplierName}):super(name: supplierName);

}