import 'package:flutter/material.dart';
import 'package:gailey_boys/models/models.dart';
import 'package:gailey_boys/services/strings.dart';
import 'package:gailey_boys/services/user_repository.dart';
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
    final user = Provider.of<UserRepository>(context);
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
          await user.signOut();
          print("Signed out, now get out!");
        },
      ),
    );
  }

  PopupMenuItem<String> buildActionItems(String option) {
    return PopupMenuItem<String>(
      value: option,
      child: ActionItem(option: option),
    );
  }

  void showActions(String choice) {
    if (choice == Strings.action_changeLodge) {
      // Navigator.of(context).pushNamed('/chooseLodge');
    }
  }
}
