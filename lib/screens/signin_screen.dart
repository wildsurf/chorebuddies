import 'package:chorebuddies/components/loading_spinner.dart';
import 'package:chorebuddies/services/assets.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../services/auth.dart';

class SigninScreen extends StatelessWidget {
  Widget _buildLoginButton(BuildContext context) {
    return StreamBuilder(
      stream: authService.loading,
      builder: (context, snapshot) {
        return Container(
          height: 40.0,
          child: snapshot.hasData && snapshot.data
              ? LoadingSpinner()
              : RaisedButton(
                  onPressed: () => authService.googleSignIn(),
                  child: Text('Login with Google'),
                ),
        );
      },
    );
  }

  Widget _buildBuddiesImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).secondaryHeaderColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.5,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: ClipOval(
        child: FadeInImage(
          placeholder: getPlaceholder(),
          fit: BoxFit.cover,
          image: getBuddies(),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height * 0.23
              : null,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Text(
                  "wildsurf presents",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 20.0,
                ),
                child: getLogo(),
              ),
            ],
          ),
        ),
        Container(
          child: MediaQuery.of(context).orientation == Orientation.portrait
              ? _buildBuddiesImage(context)
              : null,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 30.0,
              ),
              child: _buildLoginButton(context),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: _buildBody(context),
    );
  }
}
