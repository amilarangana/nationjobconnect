import 'package:flutter/material.dart';
import '/resources/colors.dart';

class NoData extends StatelessWidget {
  final String message;

  const NoData(this.message, {super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(message,
            style: const TextStyle(color: Colors.black)));
  }
}
