class User{

  final String name;
  String? company,phno,address;
 
  User({required this.name,required this.company,required this.phno,required this.address});

  Map<String,dynamic> toFirestore(){
    return{
        'name':name,
        'company':company,
        'phno':phno,
        'address':address,

    };

  }

}