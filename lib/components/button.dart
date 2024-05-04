import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String msg;
  final void Function()? onPressed;
  final MaterialStateProperty<Color?>? foregroundcolor;
  final MaterialStateProperty<Color?>? backgroundColor;
  const MyButton(
      {super.key,
      required this.onPressed,
      required this.msg,
      this.foregroundcolor,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          foregroundColor: foregroundcolor, backgroundColor: backgroundColor),
      onPressed: onPressed,
      child: Text(msg),
    );
  }
}
