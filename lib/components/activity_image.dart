import 'package:flutter/material.dart';

class ActivityImage extends StatelessWidget {
  final activity;
  final isSelected;
  final size;

  const ActivityImage(
      {Key key, this.activity, this.isSelected, this.size = 40.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.all(10.0),
      child: CircleAvatar(
        backgroundColor: isSelected ? activity.color : Colors.grey,
        foregroundColor: Colors.white,
        child: Icon(
          activity.icon,
          size: size * 0.7,
        ),
      ),
    );
  }
}
