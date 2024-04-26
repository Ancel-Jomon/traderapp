import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/components/mytextfeild.dart';
import 'package:traderapp/services/firestoreconnectionoptions.dart';
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
    return const Column(
      children: [
        Expanded(child: ShowRequests()),
        Divider(),
        Expanded(child: ShowUser())
      ],
    );
  }
}

