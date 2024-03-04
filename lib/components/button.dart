import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String msg; 
  final void Function()? onPressed;
  const MyButton({super.key, required this.onPressed,required this.msg});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(msg),
     
    );
  }
}
