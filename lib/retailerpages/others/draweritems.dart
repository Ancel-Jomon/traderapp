import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traderapp/retailerpages/secondarypages/orderhistory.dart';

class DrawerList {
  Widget drawerItems(BuildContext context) {
    return Column(
      children: [
        const DrawerHeader(
            child: Icon(
          Icons.abc_outlined,
          size: 20,
        )),
        ListTile(
            leading: const Icon(Icons.history_rounded),
            title: const Text('ORDER HISTORY'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryPage(),));

            }),
        ListTile(
          leading: const Icon(Icons.settings_applications),
          title: const Text('SETTINGS'),
          onTap: () {},
        )
      ],
    );
  }

  
}
