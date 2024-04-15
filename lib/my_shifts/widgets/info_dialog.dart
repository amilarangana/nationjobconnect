import 'dart:ui';

import 'package:flutter/material.dart';
import '/resources/colors.dart';
import '/widgets/common/subtitle_text.dart';
import '/widgets/common/transparent_button.dart';

class InfoDialog extends StatelessWidget {
  final String title;
  final String text;
  const InfoDialog(this.title, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
            backgroundColor: const Color(ResColors.colorPrimaryDark),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: const BorderSide(
                    width: 2.0,
                    style: BorderStyle.solid,
                    color: Color(ResColors.colorFontSplash))),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height / 6,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubTitleText(title),
                  Text(text,
                      style: const TextStyle(
                          color: Color(ResColors.colorFontSplash),
                          fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TransparentButton(
                        "Ok",
                        () => Navigator.of(context).pop(),
                      ),
                      
                    ],
                  ),
                ],
              ),
            )));
  }
}
typedef OnButtonClick = void Function();