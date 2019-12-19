import 'package:chorebuddies/screens/activities_screen.dart';
import 'package:chorebuddies/screens/signin_screen.dart';
import 'package:chorebuddies/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const appTitle = 'Chore Buddies';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.user,
      builder: (context, user) {
        if (user.hasData) {
          return ActivitiesScreen(
            user: user.data,
          );
        } else {
          return SigninScreen();
        }
      },
    );
  }
}
