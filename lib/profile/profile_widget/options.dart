import 'dart:io';

import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final String title;
  final IconData icon;
  Colors? color;

  File? selectedImage;

  final VoidCallback onPressed;

  Options({
    this.selectedImage,
    this.color,
    required this.onPressed,
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          color: selectedImage == null ? Colors.black : Colors.red,
          onPressed: onPressed,
          icon: Icon(icon),
        ),
        Text(title),
      ],
    );
  }
}
