
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/models/orderdraft.dart';
import 'package:traderapp/models/product.dart';
import 'package:traderapp/retailerpages/others/loadproduct.dart';
import 'package:traderapp/services/firestoreorderoptions.dart';
import 'package:traderapp/services/firestoreproductoptions.dart';

class PlaceOrder extends StatefulWidget {
  final String id;
   final List filters=['Available','Not Available','Available Soon','none'];

   PlaceOrder({super.key, required this.id});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  bool showfilter = false;
  bool available = true;
  bool notavailable = true;
  bool availablesoon = true;
  Stream<QuerySnapshot>? stream(id) {
    return FireretProduct().readSupplierProduct(id, widget.filters);
  }

  onPressed(String id, double total) {
    if (total != 0) {
      final Map<Product, int> map =
          Provider.of<OrderDraft>(context, listen: false).viewOderItems();
      FirestoreOrder().placeOrderitems(map, id, total);
      Provider.of<OrderDraft>(context, listen: false).emptyOrderMap();

      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text('Order Placed!'),
                backgroundColor: Colors.white,
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //double filterheight = -height / 3;

    return PopScope(
      onPopInvoked: (didPop) {
        Provider.of<OrderDraft>(context, listen: false).emptyOrderMap();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        appBar: AppBar(
          title: const Text("Place Order"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showfilter = true;
                      //filterheight = 0;
                    });
                  },
                  child: const Row(
                    children: [Text('Filter'), Icon(Icons.arrow_drop_down)],
                  )),
            )
          ],
          backgroundColor: Theme.of(context).colorScheme.background,
          foregroundColor: Theme.of(context).colorScheme.tertiary,
        ),
        body: Container(
          height: height,
          color: Colors.amber,
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Products",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 25),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const LoadProducts().allProducts(stream(widget.id))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Consumer<OrderDraft>(builder: (context, value, child) {
                    double total = value.totalPrice();
                    return MyButton(
                        onPressed: () => onPressed(widget.id, total),
                        msg: "place order :total $total");
                  }),
                )
              ],
            ),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                bottom: (showfilter == true ? 0 : -height / 3),
                child: Filter(
                  available: available,
                  notavailable: notavailable,
                  availablesoon: availablesoon,
                 
                  onPressedcancel: () {
                    setState(() {
                      showfilter = false;
                    });
                  },
                  onchangedavailable: (p0) {
                     if(p0 == false){
                     widget. filters.remove('Available');
                    }else{
                     widget. filters.add('Available');
                    }
                    setState(() {
                      available = !available;
                    });
                  },
                  onchangedavailablesoon: (p0) {
                    if(p0 == false){
                    widget.  filters.remove('Available Soon');
                    }else{
                     widget. filters.add('Available Soon');
                    }
                   setState(() {
                      availablesoon = !availablesoon;
                   });
                  },
                  onchangednotavailable: (p0) {
                     if(p0 == false){
                     widget. filters.remove('Not Available');
                    }else{
                      widget.filters.add('Not Available');
                    }
                    setState(() {
                      notavailable = !notavailable;
                    });
                  },
                ))
          ]),
        ),
      ),
    );
  }
}

class Filter extends StatelessWidget {
  final void Function()? onPressedcancel;
  final void Function(bool?)? onchangedavailable;
  final void Function(bool?)? onchangednotavailable;
  final void Function(bool?)? onchangedavailablesoon;
  final bool available;
  final bool notavailable;

  final bool availablesoon;

  const Filter(
      {super.key,
      required this.onPressedcancel,
      this.onchangedavailable,
      this.onchangednotavailable,
      this.onchangedavailablesoon,
      required this.available,
      required this.notavailable,
      required this.availablesoon});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height / 3;

    return SizedBox(
      width: width,
      height: height,
      child: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text('Availability'),
                    Column(
                      children: [
                        ListTile(
                          title: const Text('Available'),
                          leading: Checkbox(
                              value: available, onChanged: onchangedavailable),
                        ),
                        ListTile(
                          title: const Text('Not Available'),
                          leading: Checkbox(
                              value: notavailable,
                              onChanged: onchangednotavailable),
                        ),
                        ListTile(
                          title: const Text('Available soon'),
                          leading: Checkbox(
                              value: availablesoon,
                              onChanged: onchangedavailablesoon),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    
                    MyButton(onPressed: onPressedcancel, msg: 'cancel')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
