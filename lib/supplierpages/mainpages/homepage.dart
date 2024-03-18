// ignore_for_file: avoid_unnecessary_containers


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/models/products_draft.dart';
import 'package:traderapp/services/firestoreproductoptions.dart';
import 'package:traderapp/supplierpages/others/loadproducts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  
  Stream<QuerySnapshot>? productStream = FirestoreProduct().readProductInfo();
     

  

  @override
  Widget build(BuildContext context) {
    TabController controller = TabController(length: 2, vsync: this);
    return Consumer<ProductsDraft>(
        builder: (context, value, child) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: TabBar(
                    unselectedLabelColor:
                        Theme.of(context).colorScheme.secondary,
                    controller: controller,
                    tabs: const [
                      Text(
                        'Products',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Insights',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: TabBarView(controller: controller, children: [
                    Container(child: ListProducts().allProducts(productStream)),
                    Container(
                      child: const Center(child: Text('INSIGHTS')),
                    )
                  ]),
                ))
              ],
            ));
  }
}
