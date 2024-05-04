import 'package:flutter/material.dart';
//import 'package:traderapp/themes.dart';

class MyTextFeild extends StatelessWidget {
  final String hinttext;
  final TextEditingController textController;
  final bool? obscuretext;
  final String? Function(String?)? validator;
  final int? maxLines;
  const MyTextFeild(
      {super.key,
      required this.hinttext,
      required this.textController,
      this.obscuretext,
      this.validator,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        maxLines: maxLines ?? 1,
        keyboardType: maxLines == null ? null : TextInputType.multiline,
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
            
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.background)),
            fillColor: Theme.of(context).colorScheme.secondary),
        validator: validator,
      ),
    );
  }
}
