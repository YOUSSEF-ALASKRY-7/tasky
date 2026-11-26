import 'package:flutter/material.dart';

class Costumformfiled extends StatelessWidget {
  const Costumformfiled({
    super.key,
    required this.controller1,
    required this.hintText,
    this.validator,
    this.maxLines,
  });

  final TextEditingController controller1;
  final String hintText;
  final int? maxLines;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      style:
      Theme.of(context).textTheme.labelMedium,
      validator: validator,
      maxLines: maxLines,
      controller: controller1,
      decoration: InputDecoration(
        hintText: hintText,

      ),
    );
  }
}