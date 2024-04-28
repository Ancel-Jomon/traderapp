import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traderapp/models/product.dart';

class FirestoreProduct {
  final user = FirebaseAuth.instance.currentUser;

  final conref = FirebaseFirestore.instance.collection('products');

  void addProductInfo(Product product) async {
    final docum = product.toFirestore();
    docum['uid'] = '/userdetails/${user?.uid}';
    final id = conref.doc();
    docum['id'] = id.path.substring(9);
    await id.set(docum);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readProductInfo() {
    return conref
        .where('uid', isEqualTo: '/userdetails/${user?.uid}')
        .snapshots();
  }

  void deleteProduct(String? id, String? imgurl) async {
    if (imgurl != null && imgurl != '') {
      try {
        await FireStorage().deleteimage(imgurl);
      } on Exception catch (e) {
        log(e.toString());
      }
    }
    await conref.doc(id).delete();
  }

  void updateproduct(
      Product product, String? name, int? price, String? url) async {
    final docum = product.toFirestore();
    if (name != null) {
      docum['name'] = name;
    }
    if (price != null) {
      docum['price'] = price;
    }
    if (url != null) {
      docum['imgurl'] = url;
    }

    await conref.doc(product.id).update(docum);
  }
}

class FireretProduct {
  final conref = FirebaseFirestore.instance.collection('products');
  Stream<QuerySnapshot<Map<String, dynamic>>> readSupplierProduct(String id) {
    return conref.where('uid', isEqualTo: '/userdetails/$id').snapshots();
  }
}

class FireStorage {
  final user = FirebaseAuth.instance.currentUser;
  String imgurl = '';
  Future<String> uploadimage(XFile image) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child(user!.uid)
          .child('products')
          .child(image.name);

      final task = await ref.putFile(File(image.path));
      switch (task.state) {
        case TaskState.running:
          log('running');
        case TaskState.success:
          imgurl = await ref.getDownloadURL();

        default:
      }
    } catch (e) {
      log(e.toString());
    }
    return imgurl;
  }

  Future<void> deleteimage(String url) async {
    final ref = FirebaseStorage.instance.refFromURL(url);
    log('delet path${ref.fullPath}');
    return await ref.delete();
  }

  Future<String?> updateimage(XFile? img, String? url) async {
    if (img != null) {
      if (url != null && url != '') {
      final ref = FirebaseStorage.instance.refFromURL(url);
      log('updatepath ${ref.fullPath}');
      try {
        await ref.putFile(File(img.path));
      } on Exception catch (e) {
        log(e.toString());
      }
      return await ref.getDownloadURL();
    }else{
     return await uploadimage(img);
    }
      
    } else {
      return null;
    }

    
  }
}
