import 'package:flutter/material.dart';
import '/resources/colors.dart';

class SubTitleText extends StatelessWidget {
  final String text;
  const SubTitleText(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Color(ResColors.colorFontSplash),
          fontSize: 20,
          fontWeight: FontWeight.w500),
    );
  }
}
