import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class User {
  final String uid;
  final String email;
  final String photoURL;
  final String displayName;
  final DateTime lastSeen;

  User({
    @required this.uid,
    @required this.email,
    @required this.photoURL,
    @required this.displayName,
    @required this.lastSeen,
  });

  static User of(FirebaseUser user) {
    return User(
        uid: user.uid,
        email: user.email,
        photoURL: user.photoUrl,
        displayName: user.displayName,
        lastSeen: DateTime.now());
  }
}
