import 'package:flutter/material.dart';
import 'package:traderapp/models/product.dart';
import 'package:traderapp/services/firestoreproductoptions.dart';
import 'package:traderapp/supplierpages/secondarypage/updateproduct.dart';

enum MenuActions { delete ,update}

List<PopupMenuButton<MenuActions>> productPopupMenuList(BuildContext context,Product product) {
  return [
    PopupMenuButton<MenuActions>(
      onSelected: (value) async {
        switch (value) {
          case MenuActions.delete:
            final deletevalue = await showDeleteDialog(context);
            if (deletevalue) {
              FirestoreProduct().deleteProduct(product.id, product.url);
            }
            case MenuActions.update :
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProduct(product: product),));
          default:
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<MenuActions>(
              value: MenuActions.delete, child: Text("delete product")),
              const PopupMenuItem<MenuActions>(
              value: MenuActions.update, child: Text("update product")),

        ];
      },
    )
  ];
}

Future<bool> showDeleteDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('delete product'),
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
              child: const Text("delete"))
        ],
      );
    },
  ).then((value) => value ?? false);
}


