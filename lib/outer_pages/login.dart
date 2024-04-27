//import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/components/mytextfeild.dart';
//import 'package:traderapp/models/current_userdetails.dart';
import 'package:traderapp/models/retailer.dart';
import 'package:traderapp/models/supplier.dart';
//import 'package:traderapp/retailerpages/home.dart';
import 'package:traderapp/services/firebaseauthentication.dart';
import 'package:traderapp/services/firestoreoptions.dart';
//import 'package:traderapp/supplierpages/home.dart';
//import 'package:traderapp/themes.dart';

class LoginPage extends StatelessWidget {
  final void Function()? changepage;
  LoginPage({super.key, required this.changepage});

  final TextEditingController _email = TextEditingController();

  final TextEditingController _pword = TextEditingController();

  login(BuildContext context) async {
    final fireBaseAuthentication = FireBaseAuthentication();

    await fireBaseAuthentication
        .signInWithEmailPassword(_email.text.trim(), _pword.text.trim())
        .then(
          (value) => navigate(context),
        );
  }

  navigate(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirestoreReadUser().readUserInfo().then((myuser) {
        if (myuser is Supplier) {
          Navigator.pushNamedAndRemoveUntil(context, '/SupHome', (_) => false);
        } else if (myuser is Retailer) {
          Navigator.pushNamedAndRemoveUntil(context, '/RetHome', (_) => false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: 
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                    width: 100,
                    height: 100,
                    image: AssetImage('lib/assets/sell.png')),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'WELCOME BACK !',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.background),
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
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
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
          ),
        ),
      
    );
  }
}
