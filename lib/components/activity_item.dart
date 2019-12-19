import 'package:chorebuddies/components/points_count.dart';
import 'package:chorebuddies/models/activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityItem extends StatelessWidget {
  final Activity activity;

  const ActivityItem({Key key, @required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
            top: BorderSide.none,
            bottom: BorderSide(
              color: Colors.grey,
            )),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 50.0,
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: activity.color,
                  foregroundColor: Colors.white,
                  child: Icon(
                    activity.icon,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                activity.title,
                style: Theme.of(context).textTheme.title,
              ),
              Text(
                " (${activity.type})",
                style: Theme.of(context).textTheme.subtitle,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: <Widget>[
                    StarsCount(
                      stars: activity.points,
                    ),
                    Container(
                      height: 10.0,
                      width: 1,
                    ),
                    Text(DateFormat(
                      "dd/MM/yyy HH:mm",
                    ).format(activity.logged.toDate()))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
