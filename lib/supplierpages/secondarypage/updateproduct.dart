import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/components/mytextfeild.dart';
import 'package:traderapp/models/product.dart';
import 'package:traderapp/services/firestoreproductoptions.dart';

class UpdateProduct extends StatefulWidget {
  final Product product;
  late final TextEditingController namecontroller;
  late final TextEditingController pricecontroller;
  late final ImageProvider<Object>? def;
  late final String? url;
  UpdateProduct({super.key, required this.product}) {
    namecontroller = TextEditingController(text: product.productName);
    pricecontroller =
        TextEditingController(text: product.productPrice.toString());
    def = product.url != null
        ? NetworkImage(product.url!)
        : const AssetImage('lib/assets/defprod.png') as ImageProvider<Object>?;

    url = product.url;
  }

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  XFile? image;
  Uint8List? file;

  bool flag = false;

  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object>? newdef =
        image != null ? Image.memory(file!).image : widget.def;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('update product'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: newdef,
          ),
          IconButton(
            onPressed: uploadimage,
            icon: const Icon(Icons.camera),
          ),
          MyTextFeild(hinttext: 'name', textController: widget.namecontroller),
          const SizedBox(
            height: 20,
          ),
          MyTextFeild(
              hinttext: 'price', textController: widget.pricecontroller),
          const SizedBox(
            height: 20,
          ),
          MyButton(
              onPressed: () {
                update();
              },
              msg: 'update'),
          showindicator()
        ],
      ),
    );
  }

  uploadimage() async {
    XFile? img = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (img != null) {
      Uint8List filex = await img.readAsBytes();
      setState(() {
        file = filex;
        image = img;
      });

    }
  }

  void update() async {
    setState(() {
      flag=true;
    });
    final string = await FireStorage().updateimage(image, widget.url);
    FirestoreProduct().updateproduct(
        widget.product,
        widget.namecontroller.text.trim(),
        int.tryParse(widget.pricecontroller.text),
        string);
    navigate();
  }

  Widget showindicator() {
    if ( flag) {
      return const CircularProgressIndicator();
    } else {
      return const SizedBox.shrink();
    }
  }
   navigate (){
      Navigator.pop(context);

    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text('Product Updated!'),
              backgroundColor: Colors.white,
            ));
    }
}
