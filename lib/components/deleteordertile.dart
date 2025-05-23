import 'package:flutter/material.dart';
import 'package:traderapp/components/button.dart';

class DeleteOrderTile extends StatelessWidget {
  const DeleteOrderTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('delete order?'),
      content: const Text('are you sure you want to delete?'),
      actions: [
        MyButton(onPressed: () =>Navigator.pop(context,true), msg: 'delete'),
        MyButton(onPressed: () => Navigator.pop(context), msg: 'cancel')
      ],
    );
  } 
}
