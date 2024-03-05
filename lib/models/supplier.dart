import 'package:traderapp/models/user.dart';

class Supplier extends User{
  String supplierName;
  String? email,phno,address;
  
  
  Supplier({required this.supplierName,this.email,this.phno,this.address}):super(name: supplierName);

  Map<String,dynamic> toFirestore(){
    return{
        'name':supplierName,
        'email':email,
        'phno':phno,
        'address':address,

    };

  }

}