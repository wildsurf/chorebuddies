import 'package:chorebuddies/components/loading_spinner.dart';
import 'package:chorebuddies/models/activity_summary.dart';
import 'package:chorebuddies/screens/activity_profile.dart';
import 'package:chorebuddies/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  Widget _buildActivities(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: authService.db.collection("activities").snapshots(),
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

          final Map<String, ActivitySummary> groupedByPerson = Map();

          snapshot.data.documents.forEach((element) {
            final String uid = element.data["uid"];
            final int points = element.data["points"];
            groupedByPerson.putIfAbsent(uid, () => ActivitySummary());
            groupedByPerson.update(uid, (ActivitySummary s) {
              s.totalActivities++;
              s.totalPoints = s.totalPoints + points;
              return s;
            });
          });

          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: groupedByPerson.keys
                      .map(
                        (key) => ActivityProfile(
                          uid: key,
                          activitySummary: groupedByPerson[key],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildActivities(context));
  }
}
