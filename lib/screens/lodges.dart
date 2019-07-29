import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gailey_boys/blocs/lodge_bloc.dart';
import 'package:gailey_boys/models/models.dart';
import 'package:provider/provider.dart';

class LodgeState with ChangeNotifier {
  Lodge _lodge;

  get lodge => _lodge;

  set lodge(Lodge newValue) {
    _lodge = newValue;
    notifyListeners();
  }
}

class ChooseLodgeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FirebaseUser user = Provider.of<FirebaseUser>(context);
    // if (user != null) {
    List<Lodge> lodges = Provider.of<List<Lodge>>(context);
    if (lodges != null) {
      // if (activeLodge == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Choose Lodge'),
        ),
        body: LodgeItems(lodges: lodges),
      );
      // } else {
      //   return TimelineScreen(lodge: activeLodge);
      // }
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Choose Lodge'),
        ),
      );
    }
    // } else {
    //   return LoginScreen();
    // }
  }
}

class LodgeItems extends StatelessWidget {
  const LodgeItems({
    Key key,
    @required this.lodges,
  }) : super(key: key);

  final List<Lodge> lodges;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20.0),
      crossAxisSpacing: 10.0,
      crossAxisCount: 1,
      children: lodges.map((lodge) => LodgeItem(lodge: lodge)).toList(),
    );
  }
}

class LodgeItem extends StatelessWidget {
  final Lodge lodge;
  const LodgeItem({Key key, this.lodge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () async {
            LodgeService.selectLodge(user, lodge.id);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(lodge.name),
            ],
          ),
        ),
      ),
    );
  }
}
