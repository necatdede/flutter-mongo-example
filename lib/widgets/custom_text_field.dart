import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.controller,
    required this.hintText,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(hintText: hintText),
        controller: controller,
      ),
    );
  }
}
