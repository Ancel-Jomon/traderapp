import 'package:flutter/material.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/components/mytextfeild.dart';
import 'package:traderapp/services/firebaseauthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? changepage;
  const RegisterPage({super.key, required this.changepage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pword = TextEditingController();
  final TextEditingController _cpword = TextEditingController();

  final formkey = GlobalKey<FormState>();

  void register(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      final fireBaseAuthentication = FireBaseAuthentication();
      try {
        await fireBaseAuthentication
            .createWithEmailPassword(_email.text.trim(), _pword.text.trim())
            .then((usercredential) {
          if (usercredential.user!.emailVerified) {
            navigate(context);
          } else {
            gotoemailverification(context);
          }
        });
      } on FirebaseAuthException catch (e) {
        // TODO
        showDialog(
          context: context,
          builder: (context) => AlertDialog(backgroundColor: Theme.of(context).colorScheme.primary,
            content: Text(e.toString(),style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
          ),
        );
      }
    }
  }

  void gotoemailverification(BuildContext context) {
    Navigator.popAndPushNamed(context, '/EmailVerification');
  }

  void navigate(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/DetailsPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                    width: 100,
                    height: 100,
                    image: AssetImage('lib/assets/purchasing.png')),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'CREATE AN ACCOUNT !',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextFeild(
                  hinttext: 'email',
                  textController: _email,
                  validator: validateEmail,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyTextFeild(
                  hinttext: 'password',
                  textController: _pword,
                  obscuretext: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyTextFeild(
                  hinttext: 'confirm password',
                  textController: _cpword,
                  obscuretext: true,
                ),
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
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      GestureDetector(
                        onTap: widget.changepage,
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
          ),
        ),
      ),
    );
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    // if (!password.contains(RegExp(r'[A-Z]'))) {
    //   return 'Password must contain at least one uppercase letter';
    // }
    // if (!password.contains(RegExp(r'[a-z]'))) {
    //   return 'Password must contain at least one lowercase letter';
    // }
    // if (!password.contains(RegExp(r'[0-9]'))) {
    //   return 'Password must contain at least one number';
    // }
    return null; // Return null if password is valid
  }

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return "Please enter a valid email";
    }
    return null;
  }
}
