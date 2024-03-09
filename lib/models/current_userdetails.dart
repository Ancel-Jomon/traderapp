


import 'package:traderapp/models/user.dart';

late MyUser kuser;
 loadCurrentUser(MyUser nuser)  {

  
   kuser=nuser;
}

MyUser getCurrentUser() {
  return kuser;
}