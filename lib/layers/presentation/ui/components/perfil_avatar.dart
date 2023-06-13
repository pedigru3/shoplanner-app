import 'package:flutter/material.dart';

class PerfilAvatar extends StatelessWidget {
  const PerfilAvatar({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(url),
      radius: 32,
      backgroundColor: Colors.red,
    );
  }
}
