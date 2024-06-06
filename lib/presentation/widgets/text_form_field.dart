import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  TextEditingController? controller;
  String? Function(String?)? validator;
  String? label;

  TextFormFieldCustom({super.key, this.controller, this.label, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      decoration:
          InputDecoration(labelText: label, border: const OutlineInputBorder()),
    );
  }
}
