import 'package:chorebuddies/screens/activities_screen.dart';
import 'package:chorebuddies/screens/signin_screen.dart';
import 'package:chorebuddies/services/auth.dart';
import 'package:flutter/material.dart';

const appTitle = 'Chore Buddies';

class App extends StatelessWidget {

  Widget _getAppBody() {
    return StreamBuilder(
      stream: authService.user,
      builder: (context, user) {
        if (user.hasData) {
          return ActivitiesScreen();
        } else {
          return SigninScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Center(
        child: _getAppBody(),
      ),
    );
  }
}
