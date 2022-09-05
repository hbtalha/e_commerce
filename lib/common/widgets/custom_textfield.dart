import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final bool obscureText;
  final int maxLines;
  final TextInputType keyboardType;
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.title,
      this.obscureText = false,
      this.maxLines = 1,
      this.keyboardType = TextInputType.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            keyboardType: keyboardType,
            maxLines: maxLines,
            obscureText: obscureText,
            textInputAction: TextInputAction.next,
            controller: controller,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Enter your $title";
              }
              return null;
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}
