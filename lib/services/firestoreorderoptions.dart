import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:traderapp/models/product.dart';

class FirestoreOrder {
  final db = FirebaseFirestore.instance;
  late final CollectionReference<Map<String, dynamic>> orderref;
  late final CollectionReference<Map<String, dynamic>> itemref;
  final user = FirebaseAuth.instance.currentUser;
  late WriteBatch batch;

  FirestoreOrder() {
    orderref = db.collection('orders');
    itemref = db.collection('orderitems');
    batch=db.batch();
  }
  void placeOrderitems(Map<Product, int> map,String id) async{
    List ids=[];
    for (var e in map.entries){
      var docref=itemref.doc();
      ids.add(docref);
      var docum=e.key.toFirestore();
      docum['quantity']= e.value;
      batch.set(docref, docum);
    }
    await batch.commit();

    final docum={
        'retailerid':'/userdetails/${user?.uid}',
        'supplierid':'/userdetails/$id',
        'timestamp':FieldValue.serverTimestamp(),
        'orderitems':ids
    };
    await orderref.doc().set(docum);
  }
}
