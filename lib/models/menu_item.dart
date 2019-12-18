import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;

  MenuItem(this.title, {this.icon});

  static MenuItem logout = MenuItem("Log out");
}
