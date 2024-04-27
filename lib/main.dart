// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/firebase_options.dart';

import 'package:traderapp/loginorregister.dart';
import 'package:traderapp/models/current_userdetails.dart';
import 'package:traderapp/models/orderdraft.dart';

import 'package:traderapp/outer_pages/details.dart';
import 'package:traderapp/retailerpages/home.dart';
import 'package:traderapp/supplierpages/home.dart';
import 'package:traderapp/supplierpages/others/addproduct.dart';
import 'package:traderapp/themes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OrderDraft()),
        ChangeNotifierProvider(
          create: (context) => CurrentUserDraft(),
        )
      ],
      child: MaterialApp(
        title: '',
        theme: Themes().lightmode,
        home: const PreLogin(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/DetailsPage': (context) => DetailsPage(),
          '/SupHome': (context) => SupHome(),
          '/AddProduct': (context) => AddProduct(),
          '/RetHome': (context) => RetHome(),
          '/LoginOrRegister': (context) => LoginOrRegister()
        },
      ),
    );
  }
}

class PreLogin extends StatelessWidget {
  const PreLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return const LoginOrRegister();

          default:
            return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
