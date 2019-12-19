import 'dart:collection';

import 'package:chorebuddies/components/activity_item.dart';
import 'package:chorebuddies/components/loading_spinner.dart';
import 'package:chorebuddies/components/main_app_bar.dart';
import 'package:chorebuddies/models/activity.dart';
import 'package:chorebuddies/models/activity_config.dart';
import 'package:chorebuddies/screens/new_activity_screen.dart';
import 'package:chorebuddies/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ActivitiesScreen extends StatefulWidget {
  final FirebaseUser user;

  const ActivitiesScreen({Key key, this.user}) : super(key: key);

  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  LinkedHashMap<String, ActivityConfig> _activitiesConfig;

  _ActivitiesScreenState();

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_activitiesConfig == null) {
      final activitiesConfig = await ActivityConfig.loadActivityConfig(context);
      setState(() {
        _activitiesConfig = activitiesConfig;
      });
    }
  }

  void _addButtonSelect(BuildContext context) {
    print("Trying to add activity");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewActivityScreen(
          activitiesConfig: _activitiesConfig,
        ),
      ),
    );
  }

  Widget _buildActivityList(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: authService.db
            .collection("activities")
            .where(
              "uid",
              isEqualTo: widget.user.uid,
            )
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: LoadingSpinner(),
              ),
            );
          }

          if (snapshot.data.documents.length == 0) {
            return Container(
              child: Center(
                  child: Text(
                "No Activities - start doing some house work!",
              )),
            );
          }

          return ListView.builder(
            itemBuilder: (BuildContext context, int index) => ActivityItem(
                activity: Activity.fromDocument(
                    _activitiesConfig, snapshot.data.documents[index])),
            itemCount: snapshot.data.documents.length,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        "My Activities",
      ),
      body: _activitiesConfig == null
          ? Container(
              child: LoadingSpinner(),
            )
          : _buildActivityList(context),
      floatingActionButton: _activitiesConfig == null
          ? null
          : FloatingActionButton(
              onPressed: () => _addButtonSelect(context),
              child: Icon(Icons.add),
            ),
    );
  }
}
