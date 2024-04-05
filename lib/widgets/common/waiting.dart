import 'package:flutter/material.dart';
import '/resources/colors.dart';
import '/resources/utils.dart';

class Waiting extends StatelessWidget {
  const Waiting({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: Utils.getContainerDecoration(),
          child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color(ResColors.colorFontSplash)))),
    );
  }
}
