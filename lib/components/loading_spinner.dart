import 'package:flutter/cupertino.dart';

class LoadingSpinner extends StatelessWidget {
  final bool isLoading;

  const LoadingSpinner({Key key, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text(
        "Loading..."
      ),
    );
  }
}