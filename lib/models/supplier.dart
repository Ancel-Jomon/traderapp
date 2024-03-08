import 'package:traderapp/models/user.dart';

class Supplier extends User {
  String supplierName;
  String scompany, sphno, saddress;
 
 String role = "supplier";

  Supplier(
      {required this.supplierName,
      required this.scompany,
      required this.sphno,
      required this.saddress})
      : super(
            name: supplierName,
            company: scompany,
            phno: sphno,
            address: saddress);
}
