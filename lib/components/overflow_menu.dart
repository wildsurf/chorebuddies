import 'package:chorebuddies/models/menu_item.dart';
import 'package:chorebuddies/services/auth.dart';
import 'package:flutter/material.dart';

class OverflowMenu extends StatelessWidget {
  void _menuItemSelect(MenuItem i) {
    if (i == MenuItem.logout) {
      authService.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      onSelected: _menuItemSelect,
      itemBuilder: (BuildContext context) {
        return [
          MenuItem.logout,
        ]
            .map((MenuItem i) => PopupMenuItem<MenuItem>(
                  value: i,
                  child: Text(
                    i.title,
                  ),
                ))
            .toList();
      },
    );
  }
}
