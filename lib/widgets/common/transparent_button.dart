import 'package:flutter/material.dart';
import '/resources/colors.dart';

class TransparentButton extends StatelessWidget {
  final String buttonText;
  final ClickListener onButtonClick;
  const TransparentButton(this.buttonText, this.onButtonClick, {super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onButtonClick,
        child: Text(buttonText,
            style: const TextStyle(
                color: Color(ResColors.colorFontSplash), fontSize: 18)));
  }
}

typedef ClickListener = void Function();
