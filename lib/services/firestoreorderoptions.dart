

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
    batch = db.batch();
  }
  void placeOrderitems(Map<Product, int> map, String id,double total) async {
    List<DocumentReference> ids = [];
    for (var e in map.entries) {
      var docref = itemref.doc();
      ids.add(docref);
      var docum = e.key.toFirestore();
      docum['quantity'] = e.value;
      batch.set(docref, docum);
    }
    await batch.commit();
    placeOrder(id, ids, total);
  }

  void placeOrder(String id, List<DocumentReference> ids, double total) async {
    final docum = {
      'retailer_id': '/userdetails/${user?.uid}',
      'supplier_id': '/userdetails/$id',
      'timestamp': FieldValue.serverTimestamp(),
      'orderitems': ids,
      'total': total,
      'delivered':false
    };
    await orderref.doc().set(docum);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> retriveOrdersforSuppliers( bool value) {
    if (!value) {
      return orderref
        .where('supplier_id', isEqualTo: '/userdetails/${user?.uid}').where('delivered',isEqualTo: false)
        .snapshots();
    } else {
      return orderref
        .where('supplier_id', isEqualTo: '/userdetails/${user?.uid}').where('delivered',isEqualTo: true)
        .snapshots();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> retriveOrdersforRetailer(bool value) {
    if (!value) {
      return orderref
        .where('retailer_id', isEqualTo: '/userdetails/${user?.uid}').where('delivered', isEqualTo: false)
        .snapshots();
    } else {
      return orderref
        .where('retailer_id', isEqualTo: '/userdetails/${user?.uid}').where('delivered', isEqualTo: true)
        .snapshots();
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> orderitemdetail(
      String location) async {
    //final oderitem = location.substring(13);
    return await db.doc(location).get();
  }

  Future<(Product, int)> refillcartwithitems(String path) async {
    final snap = await db.doc(path).get();

    final prod = await db.collection('products').doc(snap['id']).get();

    Product p = Product.fromFirestore(prod);
    final int q = snap['quantity'];
    return (p, q);
  }

  void updateOrderItems(
      Map<Product, int> orderitemsmap,
      Map<Product, String> existingitems,
      DocumentReference id,
      double total) async {
    List<DocumentReference> ids = [];
    
    for (var e in orderitemsmap.entries) {
      if (existingitems.containsKey(e.key)) {
        if (e.value != 0) {
          final docref = itemref.doc(existingitems[e.key]!.substring(11));

          ids.add(docref);
          batch.update(docref, {'quantity': e.value});
        } else if (e.value == 0) {
          final docref = itemref.doc(existingitems[e.key]!.substring(11));
          batch.delete(docref);
        }
      } else {
        var docref = itemref.doc();
        ids.add(docref);
        var docum = e.key.toFirestore();
        docum['quantity'] = e.value;
        batch.set(docref, docum);
      }
    }
    
    batch.update(id, {'orderitems': ids, 'total': total});
    await batch.commit();
  }

  void deleteorderitems(DocumentSnapshot snap)async{

    final id=snap.id;
    final DocumentSnapshot<Map<String,dynamic>> snapshot=await orderref.doc(id).get();
    for(var e in snapshot.data()!['orderitems']){
      batch.delete(e);
    }
    batch.delete(snap.reference);
    batch.commit();

  }
}

class FireSupOrder{
   final db = FirebaseFirestore.instance;
   late final CollectionReference<Map<String, dynamic>> orderref;
   FireSupOrder(){
     orderref = db.collection('orders');
   }
  void deliverOrder(DocumentSnapshot<Map<String,dynamic>?> snap){
      final id= snap.id;
      orderref.doc(id).update({'delivered':true});
  }
}