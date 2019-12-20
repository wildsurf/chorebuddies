import 'package:chorebuddies/screens/activities_screen.dart';
import 'package:chorebuddies/screens/summary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/main_app_bar.dart';
import 'components/main_bottom_navigation.dart';

class AuthRoot extends StatefulWidget {
  final FirebaseUser user;

  const AuthRoot({Key key, this.user}) : super(key: key);

  @override
  _AuthRootState createState() => _AuthRootState();
}

class _AuthRootState extends State<AuthRoot> {
  int index;

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        "Chore Buddies",
      ),
      body: new Stack(
        children: <Widget>[
          Offstage(
            offstage: index != 0,
            child: TickerMode(
              enabled: index == 0,
              child: Scaffold(
                body: ActivitiesScreen(
                  user: widget.user,
                ),
              ),
            ),
          ),
          Offstage(
            offstage: index != 1,
            child: TickerMode(
              enabled: index == 1,
              child: Scaffold(body: Summary()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomNavigation(
        selectedIndex: index,
        onTap: (int i) {
          this.setState(() => index = i);
        },
      ),
    );
  }
}
