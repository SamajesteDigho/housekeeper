import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  const ClickableText({super.key, required this.text, this.underline = true, required this.onclick});
  final String text;
  final bool underline;
  final Function onclick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onclick(),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          decoration: underline ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}
