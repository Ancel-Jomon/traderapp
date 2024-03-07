//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/components/mytextfeild.dart';
import 'package:traderapp/services/firebaseauthentication.dart';
//import 'package:traderapp/themes.dart';

class LoginPage extends StatelessWidget {

  
  final void Function()? changepage;
  LoginPage({super.key, required this.changepage});

  final TextEditingController _email = TextEditingController();

  final TextEditingController _pword = TextEditingController();

  void login(BuildContext context) async {
    final fireBaseAuthentication = FireBaseAuthentication();

    await fireBaseAuthentication.signInWithEmailPassword(
        _email.text.trim(), _pword.text.trim()).then((value) => navigate(context),);
  }

  navigate(BuildContext context){
    final user=FirebaseAuth.instance.currentUser;
    if (user!=null) {
      
    }
    Navigator.pushNamed(context, '/RetHome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            size: 50,
            color: Theme.of(context).colorScheme.background,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'WELCOME BACK !',
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextFeild(hinttext: 'email', textController: _email),
          const SizedBox(
            height: 3,
          ),
          MyTextFeild(hinttext: 'password', textController: _pword),
          const SizedBox(
            height: 20,
          ),
          MyButton(
            msg: 'login',
            onPressed: () => login(context),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'don\'t have an account ?',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: changepage,
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
