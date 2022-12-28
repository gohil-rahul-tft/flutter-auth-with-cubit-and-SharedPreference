import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String labelText;
  final List<TextFieldValidator> validator;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.validator,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        label: Text(labelText),
        border: const OutlineInputBorder(),
      ),
      validator: MultiValidator(validator),
    );
  }
}
