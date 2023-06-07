import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button(
      {Key? key,
      required this.onPressed,
      this.isActivated = true,
      required this.label})
      : super(key: key);
  final String label;
  final VoidCallback onPressed;
  // ignore: prefer_typing_uninitialized_variables
  final isActivated;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 231,
        height: 56,
        child: ElevatedButton(
          onPressed: widget.isActivated ? widget.onPressed : null,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          child: Text(widget.label),
        ));
  }
}
