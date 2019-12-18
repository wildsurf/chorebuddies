import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Activity {
  Timestamp logged;
  String name;
  num points;
  String type;
  String uid;
  String path;

  Activity(
      {this.logged, this.name, this.points, this.type, this.uid, this.path});

  static Activity fromDocument(DocumentSnapshot documentSnapshot) {
    final documentData = documentSnapshot.data;

    return Activity(
      logged: documentData["logged"],
      name: documentData["name"],
      points: documentData["points"],
      type: documentData["type"],
      uid: documentData["uid"],
      path: documentSnapshot.documentID,
    );
  }
}

const activityIcons = {
  "dishes": Icons.toll,
  "ironing": Icons.translate,
};

const activityTitles = {
  "dishes": "Dishes",
  "ironing": "Ironing",
};

const activityColors = {
  "dishes": Colors.amber,
  "ironiming": Colors.green,
};

const activityTypes = {
  "small": "Small",
  "medium": "Medium",
  "large": "Large",
};

const activityStars = {
  "dishes": {"small": 1, "medium": 2, "large": 3},
  "ironiming": {"small": 2, "medium": 3, "large": 4},
};
