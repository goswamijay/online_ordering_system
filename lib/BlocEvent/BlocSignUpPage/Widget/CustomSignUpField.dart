import 'package:flutter/material.dart';

class CustomSignUpField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final Function validator;
  final Function onChanged;
  final bool obscureText;
  final TextInputType textInputType;

  const CustomSignUpField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.validator,
    required this.textInputType,
    required this.onChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: TextFormField(
        keyboardType: textInputType,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(hintText: hintText, labelText: labelText),
        validator: (String? value) {
          return validator(value);
        },
        onChanged: (String value) {
          onChanged(value);
        },
      ),
    );
  }
}