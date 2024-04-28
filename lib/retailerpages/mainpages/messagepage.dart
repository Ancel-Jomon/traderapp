
import 'package:flutter/material.dart';
import 'package:traderapp/retailerpages/secondarypages/showrequests.dart';

import '../secondarypages/showuser.dart';

class RetMessagePage extends StatefulWidget {
  const RetMessagePage({super.key});

  @override
  State<RetMessagePage> createState() => _RetMessagePageState();
}

class _RetMessagePageState extends State<RetMessagePage> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    //return Text('hello');
    return  Scaffold(backgroundColor: Theme.of(context).colorScheme.tertiary,//resizeToAvoidBottomInset:true,
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/2.5,child: const ShowRequests()),
            const Divider(),
            SizedBox(height: MediaQuery.of(context).size.height/2.5,child: const ShowUser())
          ],
        ),
      ),
    );
  }
}

