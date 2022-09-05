import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final double? height;
  final double? width;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(width ?? double.infinity, height ?? 50), primary: color),
      child: Text(
        text,
        style: TextStyle(
          color: color == null ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
