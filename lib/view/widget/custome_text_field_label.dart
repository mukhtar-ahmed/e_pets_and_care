import 'package:flutter/material.dart';

class CustomeTextFieldLabel extends StatelessWidget {
  const CustomeTextFieldLabel({
    Key? key,
    required this.labelText,
    required this.fontSized,
    required this.fontWeight,
    required this.color,
    required this.textAlign,
  }) : super(key: key);
  final String labelText;
  final double fontSized;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        labelText,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSized,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
