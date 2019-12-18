import 'package:chorebuddies/components/activity_item.dart';
import 'package:chorebuddies/components/loading_spinner.dart';
import 'package:chorebuddies/models/activity.dart';
import 'package:chorebuddies/models/menu_item.dart';
import 'package:chorebuddies/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ActivitiesScreen extends StatelessWidget {
  void _menuItemSelect(MenuItem i) {
    if (i == MenuItem.logout) {
      authService.signOut();
    }
  }

  Widget _buildActivitiesAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "My Activities",
      ),
      actions: <Widget>[
        PopupMenuButton<MenuItem>(
          onSelected: _menuItemSelect,
          itemBuilder: (BuildContext context) {
            return [
              MenuItem.logout,
            ]
                .map((MenuItem i) => PopupMenuItem<MenuItem>(
                      value: i,
                      child: Text(
                        i.title,
                      ),
                    ))
                .toList();
          },
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: authService.db
            .collection("activities")
            .where(
              "uid",
              isEqualTo: authService.currentUser?.uid,
            )
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: LoadingSpinner(),
              ),
            );
          }

          if (snapshot.data.documents.length == 0) {
            return Container(
              child: Center(
                  child: Text(
                "No Activities - start doing some house work!",
              )),
            );
          }

          return ListView.builder(
            itemBuilder: (BuildContext context, int index) => ActivityItem(
                activity:
                    Activity.fromDocument(snapshot.data.documents[index])),
            itemCount: snapshot.data.documents.length,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildActivitiesAppBar(context),
      body: _buildBody(context),
    );
  }
}
