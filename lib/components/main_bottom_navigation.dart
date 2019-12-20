import 'package:flutter/material.dart';

class MainBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function onTap;

  const MainBottomNavigation({
    Key key,
    this.selectedIndex,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('My Activities'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Summary'),
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      onTap: onTap,
    );
  }
}
