import 'package:flutter/material.dart';
import 'package:gailey_boys/services/auth.dart';

class TimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    return Scaffold(
      appBar: AppBar(title: Text('Timeline')),
      body: FlatButton(
        color: Colors.red,
        padding: EdgeInsets.all(8),
        child: Text('Logout'),
        onPressed: () async {
          auth.signOut();
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        },
      ),
    );
  }
}
