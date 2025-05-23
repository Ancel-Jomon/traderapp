import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/components/mytextfeild.dart';
import 'package:traderapp/models/orderdraft.dart';
import 'package:traderapp/models/product.dart';
import 'package:traderapp/services/firestoreproductoptions.dart';

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

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object> image = widget.product.url != null
        ? NetworkImage(widget.product.url!)
        : const AssetImage('lib/assets/defprod.png') as ImageProvider<Object>;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Expanded(
            child: Image(
          image: image,
          fit: BoxFit.cover,
        )),
        Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                  widget.product.productName,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                    "product price : ${widget.product.productPrice.toString()}"),
                Text(
                  'Availability ${widget.product.availability}',
                  style: TextStyle(
                      color: (widget.product.availability == 'Available'
                          ? Colors.green
                          : Colors.red)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            foregroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.tertiary),
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.primary)),
                        onPressed: (widget.product.availability == 'Available'
                            ? () => decrement()
                            : null),
                        child: const Icon(Icons.remove)),
                    Consumer<OrderDraft>(
                      builder: (context, value, child) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child:
                            Text('${value.viewOderItemCount(widget.product)}'),
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            foregroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.tertiary),
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.background)),
                        onPressed: (widget.product.availability == 'Available'
                            ? () => increment()
                            : null),
                        child: const Icon(Icons.add))
                  ],
                ),
                Consumer<OrderDraft>(
                  builder: (context, value, child) => Text(
                      '${value.viewOderItemCount(widget.product) * widget.product.productPrice}'),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [const Text('write a review'),IconButton(
                        onPressed: () async {
                          textEditingController.clear();
                          final value=await showreviewdialog();
                          if(value== true && textEditingController.text != ''){
                              FireretProduct().addreview(widget.product.id!, textEditingController.text.trim());
                          }
                          else{

                          }
                        }, icon: const Icon(Icons.rate_review))],)
              ],
            ))
      ]),
    );
  }

  Future<bool> showreviewdialog() {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(backgroundColor: Theme.of(context).colorScheme.secondary,
            content: MyTextFeild(
                  hinttext: 'enter a review',
                  textController: textEditingController,maxLines: 4,),
            actions: [
              
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text("cancel")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text("save"))
                ],
              ),
            ],
          );
        }).then((value) => value ?? false);
  }
}
