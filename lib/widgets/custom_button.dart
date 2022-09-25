import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.buttonTitle,
  }) : super(key: key);

  final Function()? onPressed;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(onPressed: onPressed, child: Text(buttonTitle)),
    );
  }
}
