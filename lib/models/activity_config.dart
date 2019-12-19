import 'dart:collection';
import 'dart:convert';

import 'package:chorebuddies/services/assets.dart';
import 'package:flutter/material.dart';

class ActivityConfig {
  final String key;
  final String title;
  final IconData icon;
  final Color color;
  final Map<String, ActivityType> types;

  // Cache the activity config
  static LinkedHashMap<String, ActivityConfig> _activityConfig;

  ActivityConfig(
      {@required this.key,
      @required this.title,
      @required this.icon,
      @required this.color,
      @required this.types});

  static ActivityConfig fromJson(String key, Map<String, dynamic> map) {
    final types = LinkedHashMap<String, ActivityType>();

    map["types"].keys.forEach((key) => types.putIfAbsent(
        key, () => ActivityType.fromJson(key, map["types"][key])));

    return ActivityConfig(
        key: key,
        title: map["title"],
        icon: activityIcons[map["icon"]],
        color: Color(int.parse(map["color"])),
        types: types);
  }

  static Future<LinkedHashMap<String, ActivityConfig>> loadActivityConfig(
      BuildContext context) async {
    // Return cached value if possible
    if (_activityConfig != null) {
      return Future.value(_activityConfig);
    }

    // Otherwise load from assets folder
    final json = await getActivityConfig(context);
    final Map<String, dynamic> data = JsonDecoder().convert(json);
    final activityConfig = LinkedHashMap<String, ActivityConfig>();
    if (data is! Map) {
      throw ('Data retrieved from API is not a Map');
    }
    data.keys.forEach((key) => {
          activityConfig.putIfAbsent(
              key, () => ActivityConfig.fromJson(key, data[key]))
        });

    return activityConfig;
  }
}

class ActivityType {
  final String key;

  final String title;
  final int points;

  ActivityType(
      {@required this.key, @required this.title, @required this.points});

  static ActivityType fromJson(String key, Map<String, dynamic> data) {
    return ActivityType(
      key: key,
      title: data["title"],
      points: data["points"],
    );
  }
}

const activityIcons = {
  "toll": Icons.toll,
  "translate": Icons.translate,
  "opacity": Icons.opacity,
  "surround_sound": Icons.surround_sound,
  "toys": Icons.toys,
};
