import 'package:flutter/material.dart';

import 'overflow_menu.dart';

class MainAppBar extends AppBar {
  final String titleText;

  MainAppBar(this.titleText)
      : super(
          title: Text(
            titleText,
          ),
          actions: <Widget>[
            OverflowMenu(),
          ],
        );
}
