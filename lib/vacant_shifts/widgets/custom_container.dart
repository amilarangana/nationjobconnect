import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final Color background;
  const CustomContainer({
    super.key,
    required this.title,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(title,
            style: TextStyle(
              fontSize: 12,
            )),
      ),
    );
  }
}
