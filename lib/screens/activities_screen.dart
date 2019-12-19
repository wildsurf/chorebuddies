import 'package:chorebuddies/components/activity_item.dart';
import 'package:chorebuddies/components/loading_spinner.dart';
import 'package:chorebuddies/components/main_app_bar.dart';
import 'package:chorebuddies/models/activity.dart';
import 'package:chorebuddies/screens/new_activity_screen.dart';
import 'package:chorebuddies/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ActivitiesScreen extends StatelessWidget {
  void _addButtonSelect(BuildContext context) {
    print("Trying to add activity");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewActivityScreen(),
      ),
    );
  }

  Widget _buildActivityList(BuildContext context) {
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
      appBar: MainAppBar(
        "My Activities",
      ),
      body: _buildActivityList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addButtonSelect(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
