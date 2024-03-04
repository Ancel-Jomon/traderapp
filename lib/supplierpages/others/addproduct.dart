import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/models/products_draft.dart';
import 'package:traderapp/models/product.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/components/mytextfeild.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key});

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController priceTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: const Text('ADD PRODUCTS'),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextFeild(
              hinttext: 'product name', textController: nameTextController),
          MyTextFeild(hinttext: 'price', textController: priceTextController),
          MyButton(onPressed: () => onPressed(context), msg: 'save')
        ],
      ),
    );
  }

  onPressed(BuildContext context) {
    final Product product = Product(
        productName: nameTextController.text,
        productPrice: int.parse(priceTextController.text));
    Provider.of<ProductsDraft>(context, listen: false).addProduct(product);

    Navigator.pop(context);

    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text('Product Added!'),
              backgroundColor: Colors.white,
            ));
  }
}
