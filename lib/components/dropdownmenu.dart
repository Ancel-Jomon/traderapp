import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
 final Color? dropdownColor;
 final String? selectedOption;
 final  List<String> options ;
 final void Function(String?)? onChanged;

  const DropDownWidget({super.key, this.dropdownColor,required this.selectedOption, this.onChanged, required this.options});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: DropdownButtonFormField(
        dropdownColor: dropdownColor,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        value: selectedOption,
        items: options.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.background))),
      ),
    );
  }
}
