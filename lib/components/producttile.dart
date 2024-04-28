import 'package:flutter/material.dart';
import 'package:traderapp/components/productpopupitems.dart';
import 'package:traderapp/models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object>?  image= product.url != null ? NetworkImage(product.url!) :const AssetImage('lib/assets/defprod.png') as ImageProvider<Object>?;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage:image
              
              ),
              const SizedBox(width: 10,),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.productName,style: const TextStyle(),),
                  Text('price:${product.productPrice.toString()}')
                ],
              ),
            ],
          ),
          Row(
            
            children: productPopupMenuList(context, product),
          ),
        ],
      ),
    );
  }
}
