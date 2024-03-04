// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/components/suppliertile.dart';
import 'package:traderapp/models/supplier.dart';
import 'package:traderapp/models/supplierdraft.dart';

class RetHomePage extends StatefulWidget {
  const RetHomePage({super.key});

  @override
  State<RetHomePage> createState() => _RetHomePageState();
}

class _RetHomePageState extends State<RetHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController controller = TabController(length: 2, vsync: this);
    return Consumer<SupplierDraft>(
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
                        'Suppliers',
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
                      itemCount: value.listOfSuppliers().length,
                      itemBuilder: (context, index) {
                        Supplier supplier = value.listOfSuppliers()[index];
                        return Card(
                          child:SupplierTile(supplier: supplier)
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
