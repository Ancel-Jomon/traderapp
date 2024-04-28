import 'package:flutter/material.dart';
//import 'package:traderapp/themes.dart';

class MyTextFeild extends StatelessWidget {
  final  String hinttext;
  final TextEditingController textController;
 final bool? obscuretext; 
  
 const MyTextFeild({super.key, required this.hinttext,required this.textController,this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(controller: textController,obscureText: obscuretext ?? false,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            labelText: hinttext,
            labelStyle: TextStyle(color:Theme.of(context).colorScheme.inversePrimary ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.background)),
            fillColor: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
