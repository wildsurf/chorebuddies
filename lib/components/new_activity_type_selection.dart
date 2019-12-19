import 'package:chorebuddies/models/activity_config.dart';
import 'package:flutter/material.dart';

class NewActivityTypeSelection extends StatelessWidget {
  final ActivityType selectedActivityType;
  final Iterable<ActivityType> selectedActivityTypes;
  final Function onSelectActivityType;

  const NewActivityTypeSelection(
      {Key key,
      @required this.selectedActivityType,
      @required this.selectedActivityTypes,
      @required this.onSelectActivityType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(
          height: 60,
          thickness: 3,
        ),
        Wrap(
          spacing: 10.0,
          runSpacing: 20.0,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          children: selectedActivityTypes.map(
            (ActivityType type) {
              return Container(
                child: ChoiceChip(
                  label: Text(
                    type.title,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  padding: EdgeInsets.all(15.0),
                  selected: selectedActivityType == type,
                  onSelected: (bool isSelected) =>
                      onSelectActivityType(isSelected ? type : null),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
