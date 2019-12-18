import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarsCount extends StatelessWidget {
  final int stars;

  const StarsCount({Key key, this.stars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Icon> _stars = List.filled(
      5,
      Icon(
        Icons.favorite,
        color: Theme.of(context).secondaryHeaderColor,
      ),
    );
    _stars.fillRange(
        stars,
        5,
        Icon(
          Icons.favorite_border,
          color: Colors.grey,
        ));

    return Container(
      width: 120.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _stars,
      ),
    );
  }
}
