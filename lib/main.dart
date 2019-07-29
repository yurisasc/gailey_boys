import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gailey_boys/screens/lodges.dart';
import 'package:gailey_boys/services/globals.dart';
import 'package:gailey_boys/services/user_repository.dart';
import 'package:provider/provider.dart';

import 'blocs/lodge_bloc.dart';
import 'models/models.dart';
import 'screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      /// User data is put into the providers list, allowing all
      /// widgets to access the data no matter how deep they
      /// are in the widget tree.
      providers: [
        StreamProvider<User>.value(value: Global.userRef.documentStream),
        StreamProvider<List<Lodge>>.value(
            value: LodgeService.getLodgesStream()),
        StreamProvider<Lodge>.value(value: LodgeService.activeLodgeStream()),
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged),
        ChangeNotifierProvider<UserRepository>.value(
            value: UserRepository.instance()),
      ],
      child: MaterialApp(
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
        ],
        home: Consumer<UserRepository>(
          builder: (context, UserRepository user, _) {
            switch (user.status) {
              case Status.Uninitialized:
                return Splash();
              case Status.Unauthenticated:
                return LoginScreen();
              case Status.Authenticating:
                return LoginScreen();
              case Status.Authenticated:
                return ChooseLodgeScreen();
              case Status.SelectedLodge:
                return TimelineScreen(lodge: UserRepository.activeLodge);
            }
          },
        ),
      ),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
