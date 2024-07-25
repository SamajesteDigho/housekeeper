import 'package:flutter/material.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';

class MyInputTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? text;
  final IconData? icon;
  final bool? enabled;
  final int? maxNumberOfLine;
  final Function? setText;
  final Function? validator;
  const MyInputTextField({
    super.key,
    required this.label,
    this.hint,
    this.icon,
    this.enabled = true,
    this.maxNumberOfLine = 1,
    this.text,
    this.setText,
    this.validator,
  });

  @override
  State<MyInputTextField> createState() => _MyInputTextFieldState();
}

class _MyInputTextFieldState extends State<MyInputTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLines: widget.maxNumberOfLine,
        enabled: widget.enabled,
        onChanged: (value) {
          if (widget.setText != null) {
            widget.setText!(value);
          }
        },
        validator: widget.validator == null ? null : (value) => widget.validator!(value),
        controller: TextEditingController(text: widget.text),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintMaxLines: 1,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(4),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          prefixIcon: widget.icon == null ? null : Icon(widget.icon, color: Colors.black, size: AppDimension.mediumIcon),
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.grey),
          labelText: widget.label,
          labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
