// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:traderapp/components/bottomitems.dart';
import 'package:traderapp/components/draweritems.dart';
import 'package:traderapp/outer_pages/logout.dart';
import 'package:traderapp/retailerpages/mainpages/homepage.dart';
import 'package:traderapp/retailerpages/mainpages/messagepage.dart';
import 'package:traderapp/retailerpages/mainpages/orderpage.dart';
import 'package:traderapp/retailerpages/mainpages/profilepage.dart';
//import 'package:traderapp/services/firebaseauthentication.dart';

class RetHome extends StatefulWidget {
  const RetHome({super.key});

  @override
  State<RetHome> createState() => _RetHomeState();
}

enum MenuActions { logout }

class _RetHomeState extends State<RetHome> {
  int selectedIndex = 0;

  final pages = [
    RetHomePage(),
    RetMessagePage(),
    RetOrderPage(),
    RetProfilePage()
  ];

  void pageNavigator(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: const Text(
          'home',
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        actions: logoutPopupMenuList(context),
      ),
      drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Column(
            children: draweritems,
          )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Theme.of(context).colorScheme.tertiary,
        currentIndex: selectedIndex,
        onTap: pageNavigator,
        items: List<BottomNavigationBarItem>.generate(name.length, (index) {
          return BottomNavigationBarItem(
              icon: iconslist[index],
              label: name[index],
              backgroundColor: Theme.of(context).colorScheme.background);
        }),
      ),
      body: pages[selectedIndex],
    );
  }
}

