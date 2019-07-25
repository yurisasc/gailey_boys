import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gailey_boys/screens/lodges.dart';
import 'package:gailey_boys/services/auth.dart';
import 'package:gailey_boys/services/globals.dart';
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
        StreamProvider<List<Lodge>>.value(value: LodgeService.getLodgesStream()),
        StreamProvider<Lodge>.value(value: LodgeService.activeLodgeStream()),
        StreamProvider<FirebaseUser>.value(value: AuthService().user),
      ],
      child: MaterialApp(
        // Firebase Analytics
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
        ],

        // Named Routes
        routes: {
          '/': (context) => LoginScreen(),
          '/chooseLodge': (context) => ChooseLodgeScreen(),
          '/timeline': (context) => TimelineScreen(),
        },
      ),
    );
  }
}
