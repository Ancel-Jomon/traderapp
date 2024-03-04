// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/models/products_draft.dart';
import 'package:traderapp/components/producttile.dart';
import 'package:traderapp/models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
                    Container(
                        child: ListView.builder(
                      itemCount: value.listOfProducts().length,
                      itemBuilder: (context, index) {
                        Product product = value.listOfProducts()[index];
                        return Card(
                          child: ProductTile(
                            product: product,
                          ),
                        );
                      },
                    )),
                    Container(
                      child: const Center(child: Text('INSIGHTS')),
                    )
                  ]),
                ))
              ],
            ));
  }
}
