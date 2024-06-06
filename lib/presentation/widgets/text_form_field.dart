import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  TextEditingController? controller;
  String? label;

  TextFormFieldCustom({super.key, this.controller, this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration:
          InputDecoration(labelText: label, border: const OutlineInputBorder()),
    );
  }
}
