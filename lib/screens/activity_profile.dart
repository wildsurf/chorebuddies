import 'package:chorebuddies/models/activity_summary.dart';
import 'package:chorebuddies/services/assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ActivityProfile extends StatelessWidget {
  final String uid;
  final ActivitySummary activitySummary;

  const ActivityProfile({
    Key key,
    this.uid,
    this.activitySummary,
  }) : super(key: key);

  Widget _buildHeader(
      BuildContext context, String displayName, NetworkImage photo) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(
          color: Colors.grey[400],
        ),
      ),
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          _buildPhoto(displayName, photo),
          _buildNameAndTitle(context, displayName),
        ],
      ),
    );
  }

  Widget _buildPhoto(String displayName, NetworkImage photo) {
    return Container(
      width: 70.0,
      height: 70.0,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(35.0)),
        child: photo != null
            ? FadeInImage(
                image: photo,
                placeholder: getPlaceholder(),
              )
            : Container(),
      ),
    );
  }

  Widget _buildNameAndTitle(BuildContext context, String displayName) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              displayName,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              activitySummary.title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final db = Firestore.instance;

    return StreamBuilder(
      stream: db.collection("users").document(uid).snapshots(),
      builder: (context, AsyncSnapshot<Object> snapshot) {
        NetworkImage photo;
        String displayName = "...";

        if (snapshot.hasData) {
          DocumentSnapshot ref = snapshot.data;
          photo = NetworkImage(ref["photoURL"]);
          displayName = ref["displayName"];
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Column(
              children: <Widget>[
                _buildHeader(context, displayName, photo),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).textTheme.body1.color,
                        ),
                        child: Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("Total Points"),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    activitySummary.totalPoints.toString(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Text("Total Activities"),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    activitySummary.totalActivities.toString(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
