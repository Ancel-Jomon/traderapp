import 'package:flutter/material.dart';

final draweritems = [
  const DrawerHeader(
      child: Icon(
    Icons.abc_outlined,
    size: 20,
  )),
  ListTile(
    leading: const Icon(Icons.history_rounded),
    title: const Text('ORDER HISTORY'),
    onTap: () {},
  ),
  ListTile(
    leading: const Icon(Icons.settings_applications),
    title: const Text('SETTINGS'),
    onTap: () {},
  )
];
