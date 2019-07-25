import 'package:flutter/material.dart';
import 'package:gailey_boys/models/models.dart';
import 'package:gailey_boys/screens/login.dart';
import 'package:gailey_boys/services/auth.dart';
import 'package:gailey_boys/services/strings.dart';
import 'package:gailey_boys/shared/actions.dart';
import 'package:provider/provider.dart';

class TimelineScreen extends StatefulWidget {
  final Lodge lodge;
  TimelineScreen({this.lodge});

  @override
  _TimelineScreenState createState() => _TimelineScreenState(lodge: lodge);
}

class _TimelineScreenState extends State<TimelineScreen> {
  final Lodge lodge;
  _TimelineScreenState({this.lodge});

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    User user = Provider.of<User>(context);
    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(lodge.name),
          actions: [
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onSelected: showActions,
              itemBuilder: (BuildContext context) {
                return Strings.actionOptions.map(buildActionItems).toList();
              },
            )
          ],
        ),
        body: FlatButton(
          color: Colors.red,
          padding: EdgeInsets.all(8),
          child: Text('Logout'),
          onPressed: () async {
            await auth.signOut();
            print("Signed out, now get out!");
            // return Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          },
        ),
      );
    } else {
      return LoginScreen();
    }
  }

  PopupMenuItem<String> buildActionItems(String option) {
    return PopupMenuItem<String>(
      value: option,
      child: ActionItem(option: option),
    );
  }

  void showActions(String choice) {
    if (choice == Strings.action_changeLodge) {
      Navigator.of(context).pushNamed('/chooseLodge');
    }
  }
}
