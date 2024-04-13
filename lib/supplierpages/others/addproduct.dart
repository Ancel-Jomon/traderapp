import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/models/products_draft.dart';
import 'package:traderapp/models/product.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/components/mytextfeild.dart';
import 'package:traderapp/services/firestoreproductoptions.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  XFile? image;
  Uint8List? file;
  String url='';
  final TextEditingController nameTextController = TextEditingController();

  final TextEditingController priceTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: const Text('ADD PRODUCTS'),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image != null ? Image.memory(file!,height: 100,width: 100,):
          Image.asset(
            'lib/assets/defprod.png',
            height: 100,
            width: 100,
          ),
          IconButton(
            onPressed: uploadimage,
            icon: const Icon(Icons.camera),
          ),
          MyTextFeild(
              hinttext: 'product name', textController: nameTextController),
          const SizedBox(
            height: 20,
          ),
          MyTextFeild(hinttext: 'price', textController: priceTextController),
          const SizedBox(
            height: 20,
          ),
          MyButton(onPressed: () => onPressed(context), msg: 'save')
        ],
      ),
    );
  }

  onPressed(BuildContext context) async {
    final url=await FireStorage().uploadimage(image!);

    final Product product = Product(
        productName: nameTextController.text,
        productPrice: int.parse(priceTextController.text,),url:url);

    FirestoreProduct().addProductInfo(product);
    navigate();
    
  }
  navigate (){
      Navigator.pop(context);

    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text('Product Added!'),
              backgroundColor: Colors.white,
            ));
    }

  uploadimage() async {
    XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      Uint8List filex= await img.readAsBytes();
      setState(() {
        file=filex;
        image=img;
      });
      
      log(img.path);
    }
  }
}
