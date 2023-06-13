import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({
    Key? key,
    required this.onPressed,
    this.isActivated = true,
    required this.label,
    this.icon,
  }) : super(key: key);
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isActivated;

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
          child: widget.icon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(widget.icon),
                    const SizedBox(width: 10),
                    Text(widget.label),
                  ],
                )
              : Text(widget.label),
        ));
  }
}
