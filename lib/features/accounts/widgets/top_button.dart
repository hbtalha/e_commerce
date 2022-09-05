import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const TopButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(50),
            color: Colors.white),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.black12.withOpacity(0.03),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              )),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
