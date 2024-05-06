import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:traderapp/services/firebaseemailverification.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  static const maxseconds=60;
  int seconds=maxseconds;
  bool sendagain = false;
  bool emailVerified = false;
  Timer? timer;
  Timer? counter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!emailVerified) {
      sendmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkverification(),
      );
    }
  }

  checkverification() async {
    if (!emailVerified) {
      final sate = await FirebaseEmailVerification().checkEmailVerification();
      log(sate.toString());

      setState(() {
        emailVerified = sate;
      });
    } else {
      Navigator.popAndPushNamed(context, '/DetailsPage');
    }
  }

  void sendmail() async {
    try {
      FirebaseEmailVerification().sendVerificationEmail();
      setState(() {
        sendagain = false;
      });
     counter=Timer.periodic(const Duration(seconds: 1), (_) { setState(() {
       seconds --;
       if(seconds==0){
        sendagain=true;
       }
     });});
    } catch (e) {
      show(e);
    }
  }

  show(e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [Text(e.toString())],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    counter?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('verification mail has been sent to your account'),
            Text('resend mail in $seconds'),
            ElevatedButton.icon(
                onPressed: sendagain ? sendmail : null,
                icon: const Icon(Icons.message),
                label: const Text('resend mail'))
          ],
        ),
      ),
    );
  }
}
