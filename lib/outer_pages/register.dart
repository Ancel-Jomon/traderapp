import 'package:flutter/material.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/components/mytextfeild.dart';
import 'package:traderapp/services/firebaseauthentication.dart';
//import 'package:traderapp/outer_pages/details.dart';
//import 'package:traderapp/themes.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? changepage;
  RegisterPage({super.key, required this.changepage});

  final TextEditingController _email = TextEditingController();

  final TextEditingController _pword = TextEditingController();

  final TextEditingController _cpword = TextEditingController();

  void register(BuildContext context) async {
    final fireBaseAuthentication = FireBaseAuthentication();
    await fireBaseAuthentication.createWithEmailPassword(
        _email.text.trim(), _pword.text.trim()).then((value) => navigate(context));
  }

  navigate(BuildContext context) {
    


    Navigator.pop(context);
    Navigator.pushNamed(context, '/DetailsPage');
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
            'CREATE AN ACCOUNT !',
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextFeild(hinttext: 'email', textController: _email),
          const SizedBox(
            height: 5,
          ),
          MyTextFeild(hinttext: 'password', textController: _pword),
          const SizedBox(
            height: 5,
          ),
          MyTextFeild(hinttext: 'confirm password', textController: _cpword),
          const SizedBox(
            height: 20,
          ),
          MyButton(
            msg: 'register',
            onPressed: () => register(context),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'already a member?',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: changepage,
                  child: Text(
                    'Login Now',
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
