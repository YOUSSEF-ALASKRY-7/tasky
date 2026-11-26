import 'package:flutter/material.dart';

class Coustemchickbox extends StatelessWidget {
  const Coustemchickbox(
      {super.key, required this.value, required this.onChanged});


  final bool value;
  final Function(bool ?) onChanged;


  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value:
      value,
      onChanged: (value) => onChanged(value),
      activeColor: const Color(
        0xff15B86C,
      ),
    )
    ;
  }
}
