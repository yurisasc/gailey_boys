import 'package:flutter/material.dart';
import 'package:gailey_boys/services/globals.dart';

class ActionItem extends StatelessWidget {
  final String option;

  const ActionItem({
    Key key,
    this.option,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Global.actionItemsIcon[option]),
        SizedBox(width: 12),
        Text(option, style: Theme.of(context).textTheme.body1),
      ],
    );
  }
}