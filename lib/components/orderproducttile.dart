import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/models/orderdraft.dart';
import 'package:traderapp/models/product.dart';

class OrderProducttile extends StatefulWidget {
  final Product product;

  const OrderProducttile({super.key, required this.product});

  @override
  State<OrderProducttile> createState() => _OrderProducttileState();
}

class _OrderProducttileState extends State<OrderProducttile> {
  increment() {
    log('increment pressed');
    Provider.of<OrderDraft>(context, listen: false)
        .addOrderItem(widget.product);
  }

  decrement() {
    log('decrement pressed');
    Provider.of<OrderDraft>(context, listen: false)
        .removeOrderItem(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      'https://www.pockettactics.com/wp-content/sites/pockettactics/2022/12/Guardian-Tales-tier-list-1.jpg')),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      widget.product.id ?? "",
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                        "product price : ${widget.product.productPrice.toString()}"),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                IconButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.primary)),
                    onPressed: () => decrement(),
                    icon: const Icon(Icons.remove)),
                Consumer<OrderDraft>(
                  builder: (context, value, child) =>
                      Text('${value.viewOderItemCount(widget.product)}'),
                ),
                IconButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.primary)),
                    onPressed: () => increment(),
                    icon: const Icon(Icons.add))
              ],
            ),
            Consumer<OrderDraft>(
              builder: (context, value, child) => Text(
                  '${value.viewOderItemCount(widget.product) * widget.product.productPrice}'),
            )
          ],
        )
      ],
    );
  }
}
