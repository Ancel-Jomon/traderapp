import 'package:flutter/material.dart';
import 'package:traderapp/services/firebaseauthentication.dart';

enum MenuActions { logout }

List<PopupMenuButton<MenuActions>> logoutPopupMenuList(BuildContext context) {
  return [
    PopupMenuButton<MenuActions>(
      onSelected: (value) async {
        switch (value) {
          case MenuActions.logout:
            final logoutvalue = await showLogoutDialog(context);
            if (logoutvalue) {
              FireBaseAuthentication()
                  .signOut()
                  .then((value) => gotoLogin(context));
            }
          default:
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<MenuActions>(
              value: MenuActions.logout, child: Text("signout"))
        ];
      },
    )
  ];
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('sign out'),
        content: const Text('are you sure'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("cancel")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("signout"))
        ],
      );
    },
  ).then((value) => value ?? false);
}

void gotoLogin(BuildContext context) {
  Navigator.of(context)
      .pushNamedAndRemoveUntil('/LoginOrRegister', (route) => false);
}
