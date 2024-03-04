import 'package:flutter/material.dart';
//import 'package:traderapp/themes.dart';

class MyTextFeild extends StatelessWidget {
  final hinttext;
  final TextEditingController textController;
  
 const   MyTextFeild({super.key, required this.hinttext,required this.textController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(controller: textController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            hintText: hinttext,
            hintStyle: TextStyle(color:Theme.of(context).colorScheme.inversePrimary ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.background)),
            fillColor: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
