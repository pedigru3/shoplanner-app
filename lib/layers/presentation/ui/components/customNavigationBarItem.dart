import 'package:flutter/material.dart';

class CustomNavigationBarItem extends StatelessWidget {
  const CustomNavigationBarItem({
    super.key,
    required this.iconData,
    required this.label,
    this.isActive = false,
    this.onTap = _defaultOnTap,
  });
  final IconData iconData;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  static void _defaultOnTap() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        color: Colors.transparent,
        child: Row(
          children: [
            Icon(
              iconData,
              color: isActive ? Colors.red : Colors.grey,
            ),
            const SizedBox(width: 10),
            AnimatedDefaultTextStyle(
              style: TextStyle(
                  fontSize: isActive ? 16 : 15,
                  color: isActive ? Colors.red : Colors.grey),
              child: Text(label),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
            ),
          ],
        ),
      ),
    );
  }
}
