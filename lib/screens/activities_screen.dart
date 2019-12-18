import 'package:chorebuddies/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: authService.profile,
        builder: (context, snapshot) {
          return RaisedButton(
            onPressed: () => authService.signOut(),
            child: Text('Logout'),
          );
        },
      ),
    );
  }
}
