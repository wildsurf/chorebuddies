import 'dart:collection';

import 'package:chorebuddies/components/loading_spinner.dart';
import 'package:chorebuddies/components/new_activity_selection.dart';
import 'package:chorebuddies/components/new_activity_type_selection.dart';
import 'package:chorebuddies/components/points_count.dart';
import 'package:chorebuddies/models/activity_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewActivityScreen extends StatefulWidget {
  final FirebaseUser user;
  final LinkedHashMap<String, ActivityConfig> activitiesConfig;

  const NewActivityScreen(
      {Key key, @required this.user, @required this.activitiesConfig})
      : super(key: key);

  @override
  _NewActivityScreenState createState() => _NewActivityScreenState();
}

class _NewActivityScreenState extends State<NewActivityScreen> {
  ActivityConfig _selectedActivity;
  ActivityType _selectedActivityType;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    this.isLoading = false;
  }

  final db = Firestore.instance;

  void _logActivity() async {
    try {
      this.setState(() => isLoading = true);

      await db.collection('activities').add({
        'name': _selectedActivity.key,
        'points': _selectedActivityType.points,
        'type': _selectedActivityType.key,
        'logged': Timestamp.now(),
        "uid": widget.user.uid,
      });

      Navigator.of(context).pop();
    } catch (error) {} finally {
      this.setState(() => isLoading = false);
    }
  }

  void _selectActivity(ActivityConfig a) {
    this.setState(() => _selectedActivityType = null);
    if (_selectedActivity == null || _selectedActivity != a) {
      this.setState(() => _selectedActivity = a);
    } else {
      this.setState(() => _selectedActivity = null);
    }
  }

  Widget _buildActivitySelection() {
    return NewActivitySelection(
      onSelectActivity: _selectActivity,
      selectedActivity: _selectedActivity,
      activityConfigs: widget.activitiesConfig.values,
    );
  }

  Widget _buildActivityTypeSelection() {
    if (_selectedActivity == null) {
      return Container();
    }

    return NewActivityTypeSelection(
      selectedActivityTypes: _selectedActivity.types.values,
      onSelectActivityType: (ActivityType type) {
        setState(() {
          _selectedActivityType = type;
        });
      },
      selectedActivityType: _selectedActivityType,
    );
  }

  Widget _buildSendButton() {
    if (_selectedActivityType == null) {
      return Container();
    }

    return Column(
      children: <Widget>[
        Divider(
          height: 60,
          thickness: 3,
        ),
        PointsCount(
          points: _selectedActivityType.points,
        ),
        Divider(
          height: 60,
          thickness: 3,
        ),
        SizedBox(
          height: 60.0,
          child: isLoading
              ? LoadingSpinner()
              : RaisedButton(
                  child: Text(
                    "Log activity",
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: _logActivity,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log new activity'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: Center(
          child: Column(
            children: [
              _buildActivitySelection(),
              _buildActivityTypeSelection(),
              _buildSendButton(),
            ],
          ),
        ),
      ),
    );
  }
}
