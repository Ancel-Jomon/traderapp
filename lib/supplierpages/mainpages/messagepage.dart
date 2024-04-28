
import 'package:flutter/material.dart';
//import 'package:traderapp/supplierpages/secondarypages/showuser.dart';
import 'package:traderapp/supplierpages/secondarypage/showrequests.dart';
import 'package:traderapp/supplierpages/secondarypage/showuser.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
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

