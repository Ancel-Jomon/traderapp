
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/api/pdf_api_generate.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/models/current_userdetails.dart';
import 'package:traderapp/models/invoiceitem.dart';
import 'package:traderapp/models/user.dart';
import 'package:traderapp/services/firestoreorderoptions.dart';

class PerOrderItems extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>?> snapshot;
  final bool value;
  PerOrderItems({super.key, required this.snapshot, required this.value,required this.orderdata});
  final List<InvoiceItem> invoiceitems = [];
   final DocumentSnapshot<Map<String, dynamic>>? orderdata;

  Future<DocumentSnapshot<Map<String, dynamic>>> future(String id) {
    return FirestoreOrder().orderitemdetail(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(flex: 2, child: Text('orderitems')),
            Expanded(
                child: Text(
              'quantity',
              textAlign: TextAlign.end,
            )),
            Expanded(
                child: Text(
              'subtotal',
              textAlign: TextAlign.end,
            )),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data()!['orderitems'].length,
          itemBuilder: (context, index) {
            DocumentReference ref = snapshot.data()!['orderitems'][index];
            final path = ref.path;

            return FutureBuilder(
              future: future(path),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic>? snap = snapshot.data!.data();
                  invoiceitems.add(InvoiceItem(
                      name: snap!['name'],
                      price: snap['price'],
                      quantity: snap['quantity']));
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${snap['name']}',
                        ),
                      ),
                      Expanded(
                          child: Text(
                        '${snap['quantity']}',
                        textAlign: TextAlign.end,
                      )),
                      Expanded(
                          child: Text(
                        '₹${snap['price'] * snap['quantity']}',
                        textAlign: TextAlign.end,
                      )),
                    ],
                  );
                } else {
                  return const Text('');
                }
              },
            );
          },
        ),
        showoption(context, value)
      ],
    );
  }

   Widget showoption(BuildContext context, bool value)  {
    
    if (!value) {
      return MyButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(backgroundColor: Theme.of(context).colorScheme.secondary,
                title:  Text('generate bill',style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text(
                        'files will downloaded to: /storage/emulated/0/Download',style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
                    MyButton(
                        onPressed: () async {
                           Navigator.pop(context,true);
                         
                        },
                        msg: 'generate')
                  ],
                ),
              ),
            ).then((value) async{
              if (value ?? false) {
                  final MyUser user=Provider.of<CurrentUserDraft>(context,listen: false).getCurrentUser();
                  await PdfApiGenerate.generate(invoiceitems,orderdata!.data()!,user).then((value) => 
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString()))));
                
              } 
            });
             
          },
          msg: 'generate bill');
    }
    else {
      return const SizedBox.shrink();
    }
  }
}
