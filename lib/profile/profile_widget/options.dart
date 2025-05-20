import 'dart:io';

import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final String title;
  final IconData icon;
  File? selectedImage;
  VoidCallback onPressed;
  Options({
    this.selectedImage,
    required this.title,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          color: selectedImage == null ? Colors.grey : Colors.red,
          onPressed: onPressed,
          icon: Icon(icon),
        ),
        Text(
          title,
          style: TextStyle(
            color: selectedImage == null ? Colors.grey.shade800 : Colors.red,
          ),
        ),
      ],
    );
  }
}