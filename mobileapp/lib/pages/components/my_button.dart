import 'package:flutter/material.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.onClick,
    this.textColor = Colors.black,
    this.btnColor = Colors.blue,
    this.btnWidth,
  });
  final String text;
  final Function onClick;
  final Color textColor;
  final Color btnColor;
  final double? btnWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: btnWidth,
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        onPressed: () => onClick(),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: AppDimension.largeText,
          ),
        ),
      ),
    );
  }
}
