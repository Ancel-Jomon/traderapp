
import 'package:traderapp/models/user.dart';

class Retailer extends MyUser {
  String retailername;
  String rcompany, rphno, raddress;
 
 String role = "retailer";

  Retailer(
      {required this.retailername,
      required this.rcompany,
      required this.rphno,
      required this.raddress})
      : super(
            name: retailername,
            company: rcompany,
            phno: rphno,
            address: raddress);
}
