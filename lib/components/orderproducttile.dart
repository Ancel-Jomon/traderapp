import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traderapp/models/product.dart';

class OrderProducttile extends StatefulWidget {
  final Product product;

  const OrderProducttile({super.key, required this.product});

  @override
  State<OrderProducttile> createState() => _OrderProducttileState();
}

class _OrderProducttileState extends State<OrderProducttile> {
  int count = 0;
  int price = 0;

  increment() {
    setState(() {
      count++;
      price += widget.product.productPrice;
    });
  }

  decrement() {
    if (count != 0) {
      setState(() {
        count--;
        price -= widget.product.productPrice;
      });
    }
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
              Column(
                children: [
                  Text(widget.product.productName),
                  Text(
                      "product price : ${widget.product.productPrice.toString()}")
                ],
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
            Text(count.toString()),
            IconButton(style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primary)),
                onPressed: () => increment(), icon: const Icon(Icons.add))
          ],
        ),
        Text("total : ${price.toString()}")
                  ],
                )
      ],
    );
  }
}
