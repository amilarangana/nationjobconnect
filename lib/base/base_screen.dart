import 'package:flutter/material.dart';

abstract class BaseScreen extends StatefulWidget {
  BaseScreen({Key? key}) : super(key: key);
}

abstract class BaseState<Screen extends BaseScreen> extends State<Screen> {
  String screenName();
  dynamic getExtra();
}
