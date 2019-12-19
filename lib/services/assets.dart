import 'package:flutter/material.dart';

Image getLogo() {
  return Image.asset(
    "assets/images/chore_buddies_logo.png",
    fit: BoxFit.fitWidth,
  );
}

IconData getCategoryIcon(String name) {
  return Icons.toll;
}

AssetImage getBuddies() {
  return AssetImage("assets/images/buddies.jpg");
}

AssetImage getPlaceholder() {
  return AssetImage("assets/images/placeholder.png");
}

Future<String> getActivityConfig(BuildContext context) {
  return DefaultAssetBundle.of(context)
      .loadString('assets/data/activity_config.json');
}
