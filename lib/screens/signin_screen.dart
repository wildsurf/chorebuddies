import 'package:chorebuddies/components/loading_spinner.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';

class SigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.loading,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return LoadingSpinner();
        } else {
          return RaisedButton(
            onPressed: () => authService.googleSignIn(),
            child: Text('Login with Google'),
          );
        }
      },
    );
  }
}
