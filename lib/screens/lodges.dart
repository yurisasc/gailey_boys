import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gailey_boys/services/globals.dart';
import 'package:gailey_boys/services/models.dart';
import 'package:provider/provider.dart';

class LodgeState with ChangeNotifier {
  String _lodgeId;

  get lodgeId => _lodgeId;

  set lodgeId(String newValue) {
    _lodgeId = newValue;
    notifyListeners();
  }
}

class ChooseLodgeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return FutureBuilder(
      future: LodgeService.getUserLodge(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasData) {
          List<Lodge> lodges = snap.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Choose Lodge'),
            ),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: lodges.map((lodge) => LodgeItem(lodge: lodge)).toList(),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Choose Lodge'),
            ),
          );
        }
      },
    );
  }
}

class LodgeItem extends StatelessWidget {
  final Lodge lodge;
  const LodgeItem({Key key, this.lodge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(lodge.name),
    );
  }
}
