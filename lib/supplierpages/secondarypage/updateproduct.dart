import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/components/mytextfeild.dart';
import 'package:traderapp/models/product.dart';

class UpdateProduct extends StatelessWidget {
  final Product product;
  late final TextEditingController namecontroller;
  late final TextEditingController pricecontroller;
  late final ImageProvider<Object>? def;
  UpdateProduct({super.key, required this.product}) {
    namecontroller = TextEditingController(text: product.productName);
    pricecontroller =
        TextEditingController(text: product.productPrice.toString());
    def = product.url != null
        ? NetworkImage(product.url!)
        : const AssetImage('lib/assets/defprod.png') as ImageProvider<Object>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('update product'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: def,
          ),
          IconButton(
            onPressed: uploadimage,
            icon: const Icon(Icons.camera),
          ),
          MyTextFeild(hinttext: 'name', textController: namecontroller),
          const SizedBox(
            height: 20,
          ),
          MyTextFeild(hinttext: 'price', textController: pricecontroller),
          const SizedBox(
            height: 20,
          ),
          MyButton(
              onPressed: () {
                update(namecontroller.text, pricecontroller.text);
              },
              msg: 'update')
        ],
      ),
    );
  }

  void uploadimage() {}

  void update(String name, String price) {
    log(name);
    log(price);
  }
}
