
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
    Provider.of<OrderDraft>(context, listen: false)
        .addOrderItem(widget.product);
  }

  decrement() {
    Provider.of<OrderDraft>(context, listen: false)
        .removeOrderItem(widget.product);
  }

  @override
  Widget build(BuildContext context) {
        final ImageProvider<Object>?  image= widget.product.url != null ? NetworkImage(widget.product.url!) :const AssetImage('lib/assets/defprod.png') as ImageProvider<Object>?;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
               CircleAvatar(
                  radius: 40,
                  backgroundImage:image),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      widget.product.productName ,
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
