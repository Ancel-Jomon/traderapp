
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/models/orderdraft.dart';
import 'package:traderapp/models/product.dart';
import 'package:traderapp/retailerpages/others/loadproduct.dart';
import 'package:traderapp/services/firestoreconnectionoptions.dart';
import 'package:traderapp/services/firestoreorderoptions.dart';
import 'package:traderapp/services/firestoreproductoptions.dart';

class UpdateOrders extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>?> snapshot;
  const UpdateOrders({super.key, required this.snapshot});

  @override
  State<UpdateOrders> createState() => _UpdateOrdersState();
}

class _UpdateOrdersState extends State<UpdateOrders> {
  String msg = '';
  Stream<QuerySnapshot>? stream(String id) {
    return FireretProduct().readSupplierProduct(id,'Available');
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> supplierdetail(
      DocumentSnapshot<Map<String, dynamic>?> documentSnapshot) async {
    final DocumentSnapshot<Map<String, dynamic>> docsnap =
        await FirestoreConnection().collectSupplierInfo(documentSnapshot);

    return docsnap;
  }

  void setCart(DocumentSnapshot<Map<String, dynamic>?> snap) async {
    for (var e in snap.data()!['orderitems']) {
      final id = e.path;
      await FirestoreOrder().refillcartwithitems(id).then((value) =>
          Provider.of<OrderDraft>(context, listen: false)
              .refillorders(value.$1, value.$2, id));
    }
    
  }

  @override
  void initState() {
   
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setCart(widget.snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        Provider.of<OrderDraft>(context, listen: false).emptyOrderMap();
      },
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Theme.of(context).colorScheme.tertiary,
          title: const Text('update orders'),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        body: Column(
          children: [
            FutureBuilder(
              future: supplierdetail(widget.snapshot),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const LoadProducts()
                      .allProducts(stream(snapshot.data!.id));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Center(
                child: Column(
                  children: [
                    Consumer<OrderDraft>(
                      builder: (context, value, child) {
                        double total = value.totalPrice();
                        return MyButton(
                            onPressed: () =>
                                onpressed(widget.snapshot.reference, total),
                            msg: 'place order :total $total');
                      },
                    ),
                    Text(
                      msg,
                      style: const TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  onpressed(DocumentReference id, double total) {
    if (!checkitems() ) {
     setState(() {
        msg='Sorry ! cannot place orders with zero items';
     });
    } else {
      final Map<Product, int> map =
          Provider.of<OrderDraft>(context, listen: false).viewOderItems();
      final Map<Product, String> items =
          Provider.of<OrderDraft>(context, listen: false).itemspresent();
      FirestoreOrder().updateOrderItems(map, items, id, total);

      Provider.of<OrderDraft>(context, listen: false).emptyOrderMap();

      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text('Order updated!'),
                backgroundColor: Colors.white,
              ));
    }
  }
  
  bool checkitems() {
    
   final map= Provider.of<OrderDraft>(context,listen:false).viewOderItems();
   for(var val in map.values){
    if (val>0){
      return true;
    }
   }
   return false;
  }
}
