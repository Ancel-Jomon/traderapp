import 'package:flutter/material.dart';
//import 'package:traderapp/themes.dart';

class MyTextFeild extends StatelessWidget {
  final String hinttext;
  final TextEditingController textController;
  final bool? obscuretext;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const MyTextFeild(
      {super.key,
      required this.hinttext,
      required this.textController,this.onChanged,
      this.obscuretext,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(//onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: textController,
        obscureText: obscuretext ?? false,
        decoration: InputDecoration(
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            labelText: hinttext,
            labelStyle:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.background)),
            fillColor: Theme.of(context).colorScheme.secondary),
        validator: validator,
      ),
    );
  }
}
