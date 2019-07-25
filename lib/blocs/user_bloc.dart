import 'package:firebase_auth/firebase_auth.dart';
import 'package:gailey_boys/models/models.dart';
import 'package:rxdart/rxdart.dart';

class ActiveLodgeBloc {
  final _activeLodgeSubject = BehaviorSubject<Lodge>();
  Observable<Lodge> get activeLodge => _activeLodgeSubject.stream;

  ActiveLodgeBloc(Future<FirebaseUser> user) {
    _fetch(user);
  }

  dispose() {
    _activeLodgeSubject.close();
  }

  _fetch(Future<FirebaseUser> user) {
    // user.then((u) {
    //   Firestore.instance
    //       .collection('users')
    //       .where('uid', isEqualTo: u.uid)
    //       .snapshots()
    //       .listen((QuerySnapshot qs) async {
    //     Lodge lodge;
    //     for (DocumentSnapshot ds in qs.documents) {
    //       User u = User.fromMap(ds.data);
    //       if (u.activeLodge != null) {
    //         Firestore.instance
    //             .collection('lodges')
    //             .where('id', isEqualTo: u.activeLodge)
    //             .snapshots()
    //             .listen((QuerySnapshot qs) {
    //           for (DocumentSnapshot ds in qs.documents) {
    //             lodge = Lodge.fromMap(ds.data);
    //           }
    //         });
    //       }
    //     }
    //     _activeLodgeSubject.sink.add(lodge);
    //   });
    // });
  }
}
