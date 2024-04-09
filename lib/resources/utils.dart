import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/resources/dimensions.dart';

import 'colors.dart';

class Utils {
  static String getDate(DateTime date) {
    DateFormat dateFormat = new DateFormat('EE dd/MM');
    return dateFormat.format(date);
  }

  static String getTime(DateTime date) {
    DateFormat dateFormat = new DateFormat('HH:mm');
    return dateFormat.format(date);
  }

  static BoxDecoration getTextViewDecoration() {
    return BoxDecoration(
      color: const Color(ResColors.colorPrimaryDark),
      borderRadius:
          const BorderRadius.all(Radius.circular(ResDimensions.corner_radius)),
      border: Border.all(
          width: 1.0,
          color: const Color(ResColors.colorPrimary).withOpacity(1)),
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.grey.withOpacity(0.2),
      //     spreadRadius: 3,
      //     blurRadius: 10,
      //     offset: Offset(0, 3), // changes position of shadow
      //   ),
      // ]
    );
  }

  static BoxDecoration getTransaparentButtonDecoration() {
    return BoxDecoration(
      // color: Color(ResColors.colorPrimaryDark),
      borderRadius:
          const BorderRadius.all(Radius.circular(ResDimensions.corner_radius)),
      border: Border.all(
          width: 1.0,
          color: const Color(ResColors.colorFontSplash).withOpacity(1)),
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.grey.withOpacity(0.2),
      //     spreadRadius: 3,
      //     blurRadius: 10,
      //     offset: Offset(0, 3), // changes position of shadow
      //   ),
      // ]
    );
  }

  static BoxDecoration getContainerDecoration() {
    return BoxDecoration(
        color: const Color(ResColors.colorPrimaryDark),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        // border: Border.all(width: 1.5, color: Colors.white.withOpacity(1)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ]);
  }

  static InputDecoration getInputDecoration(
      String labalText, String? errorText) {
    return InputDecoration(
        filled: true,
        fillColor: const Color(ResColors.colorPrimaryDark),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(ResColors.colorPrimary))),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(ResColors.colorPrimary))),
        labelText: labalText,
        alignLabelWithHint: true,
        errorText: errorText,
        labelStyle: const TextStyle(
            color: Color(ResColors.colorFontSplash),
            fontSize: ResDimensions.fontSizeDataEntry),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.red)));
  }

  static Future<String?> getDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String? deviceId;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor;
    }
    return deviceId;
  }
}
