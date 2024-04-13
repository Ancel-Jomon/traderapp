import 'package:flutter/material.dart';
import 'package:traderapp/components/productpopupitems.dart';
import 'package:traderapp/models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object>?  image= product.url != null ? NetworkImage(product.url!) :const AssetImage('lib/assets/defprod.png') as ImageProvider<Object>?;
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage:image

            ),
            Row(
              
              children: productPopupMenuList(context, product),
            ),
          ],
        ),
        ListTile(
          title: Text(product.productName),
          trailing: Text(product.productPrice.toString()),
        ),
      ],
    );
  }
}
