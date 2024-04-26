import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/components/mytextfeild.dart';
import 'package:traderapp/retailerpages/secondarypages/showrequests.dart';
import 'package:traderapp/services/firestoreconnectionoptions.dart';

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
    return const Column(
      children: [
        Expanded(child: ShowRequests()),
        Divider(),
        Expanded(child: ShowUser())
      ],
    );
  }
}

