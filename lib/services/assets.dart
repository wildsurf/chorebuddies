

import 'package:flutter/material.dart';

Image getLogo() {
  return Image.asset(
    "assets/images/chore_buddies_logo.png",
    fit: BoxFit.fitWidth,
  );
}

AssetImage getBuddies() {
  return AssetImage("assets/images/buddies.jpg");
}

AssetImage getPlaceholder() {
  return AssetImage("assets/images/placeholder.png");
}