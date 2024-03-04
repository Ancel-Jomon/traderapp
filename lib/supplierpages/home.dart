// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:traderapp/components/bottomitems.dart';
//import 'package:traderapp/components/bottomitems.dart';
import 'package:traderapp/components/draweritems.dart';
import 'package:traderapp/supplierpages/mainpages/homepage.dart';
import 'package:traderapp/supplierpages/mainpages/messagepage.dart';
import 'package:traderapp/supplierpages/mainpages/orderpage.dart';
import 'package:traderapp/supplierpages/mainpages/profilepage.dart';
//import 'package:traderapp/themes.dart';

class SupHome extends StatefulWidget {
  const SupHome({super.key});

  @override
  State<SupHome> createState() => _SupHomeState();
}

class _SupHomeState extends State<SupHome> {
  int selectedIndex = 0;

  final pages = [HomePage(), MessagePage(), OrderPage(), ProfilePage()];

  void onPressed() {
    Navigator.pushNamed(context, '/AddProduct');
  }

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
      floatingActionButton: FloatingActionButton(
          onPressed: onPressed,
          child: const Icon(Icons.add)),
    );
  }
}
