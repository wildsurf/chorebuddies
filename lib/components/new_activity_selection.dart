import 'package:chorebuddies/models/activity_config.dart';
import 'package:flutter/material.dart';

import 'activity_image.dart';

class NewActivitySelection extends StatelessWidget {
  final Iterable<ActivityConfig> activityConfigs;
  final ActivityConfig selectedActivity;
  final Function onSelectActivity;

  const NewActivitySelection(
      {Key key,
      @required this.activityConfigs,
      @required this.selectedActivity,
      @required this.onSelectActivity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: activityConfigs
          .map((a) => GestureDetector(
              onTap: () => onSelectActivity(a),
              child: Column(
                children: <Widget>[
                  ActivityImage(
                    activity: a,
                    isSelected: a == selectedActivity,
                    size: 80.0,
                  ),
                  Text(
                    a.title,
                  )
                ],
              )))
          .toList(),
    );
  }
}
