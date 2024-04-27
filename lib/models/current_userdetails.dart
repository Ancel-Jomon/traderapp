


import 'package:flutter/foundation.dart';
import 'package:traderapp/models/user.dart';



class CurrentUserDraft extends ChangeNotifier{
 late MyUser kuser;
 loadCurrentUser(MyUser nuser)  {

  
   kuser=nuser;
   notifyListeners();
}

MyUser getCurrentUser() {
  return kuser;
}
}