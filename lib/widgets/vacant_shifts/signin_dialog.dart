import 'dart:ui';

import 'package:flutter/material.dart';
import '/resources/colors.dart';
import '/resources/dimensions.dart';
import '/resources/utils.dart';
import '/widgets/common/subtitle_text.dart';
import '/widgets/common/transparent_button.dart';

class SigninDialog extends StatefulWidget {
  final ValidateListener onValidate;
  const SigninDialog({super.key, required this.onValidate});

  @override
  _SigninDialogState createState() => _SigninDialogState();
}

class _SigninDialogState extends State<SigninDialog> {
  final _loginFormKey = GlobalKey<FormState>();
  // var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();

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
                height: MediaQuery.of(context).size.height / 3,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Form(
                    key: _loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SubTitleText("Form"),
                        // TextFormField(
                        //   controller: emailTextController,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return "First Name can not be empty";
                        //     }
                        //     return null;
                        //   },
                        //   style: const TextStyle(
                        //       color: Color(ResColors.colorFontSplash),
                        //       fontSize: ResDimensions.fontSizeDataEntry),
                        //   decoration: Utils.getInputDecoration("Name", null),
                        //   cursorColor: const Color(ResColors.colorFontSplash),
                        // ),
                        TextFormField(
                          controller: passwordTextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "FB Profile can not be empty";
                            }
                            return null;
                          },
                          obscureText: false,
                          style: const TextStyle(
                              color: Color(ResColors.colorFontSplash),
                              fontSize: ResDimensions.fontSizeDataEntry),
                          decoration:
                              Utils.getInputDecoration("FB Profile", null),
                          cursorColor: const Color(ResColors.colorFontSplash),
                        ),
                        TransparentButton(
                          "Apply",
                          () {
                            if (_loginFormKey.currentState!.validate()) {
                              widget.onValidate(
                                  passwordTextController.text.trim());
                            }
                          },
                        ),
                      ],
                    )))));
  }
}

typedef ValidateListener = void Function(String fbProfile);
