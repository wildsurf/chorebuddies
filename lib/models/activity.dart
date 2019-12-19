import 'dart:collection';

import 'package:chorebuddies/models/activity_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Activity {
  Color color;
  Timestamp logged;
  IconData icon;
  String title;
  num points;
  String type;
  String uid;
  String path;

  Activity(
      {this.color,
      this.icon,
      this.logged,
      this.title,
      this.points,
      this.type,
      this.uid,
      this.path});

  static Activity fromDocument(
      LinkedHashMap<String, ActivityConfig> activitiesConfig,
      DocumentSnapshot documentSnapshot) {
    final documentData = documentSnapshot.data;
    final String activityName = documentData["name"];
    final ActivityConfig activityConfig = activitiesConfig[activityName];

    return Activity(
      icon: activityConfig.icon,
      color: activityConfig.color,
      logged: documentData["logged"],
      title: activityConfig.title,
      points: documentData["points"],
      type: activityConfig.types[documentData["type"]].title,
      uid: documentData["uid"],
      path: documentSnapshot.documentID,
    );
  }
}
