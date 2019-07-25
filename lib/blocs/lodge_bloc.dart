import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gailey_boys/models/models.dart';
import 'package:gailey_boys/services/db.dart';
import 'package:rxdart/rxdart.dart';

class LodgeService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Collection<Lodge> lodgeRef = Collection<Lodge>(path: 'lodges');
  static final UserData<User> userRef = UserData<User>(collection: 'users');

  static Stream<List<Lodge>> getLodgesStream() {
    return Observable(_auth.onAuthStateChanged).switchMap((user) {
      if (user != null) {
        var snapshots = lodgeRef.ref
            .where('memberIds', arrayContains: user.uid)
            .snapshots();
        return snapshots.map((list) =>
            list.documents.map((doc) => Lodge.fromMap(doc.data)).toList());
      } else {
        return Observable<List<Lodge>>.just(null);
      }
    });
  }

  static Stream<Lodge> activeLodgeStream() {
    return Observable(_auth.onAuthStateChanged).switchMap((user) {
      if (user != null) {
        return lodgeRef.ref
            .where('isActive', arrayContains: user.uid)
            .snapshots()
            .map((list) {
          if (list.documents.isNotEmpty) {
            return list.documents.map((doc) => Lodge.fromMap(doc.data)).first;
          } else {
            return null;
          }
        });
      } else {
        return Observable<Lodge>.just(null);
      }
    });
  }

  static Future<WriteBatch> _setInactive(WriteBatch batch, String uid) async {
    var newData = {
      'isActive': FieldValue.arrayRemove([uid]),
    };

    // lodgeRef.ref
    //     .where('isActive', arrayContains: uid)
    //     .snapshots()
    //     .listen((data) => data.documents.forEach((doc) {
    //           batch.updateData(doc.reference, newData);
    //           return batch;
    //         }));

    var a = await lodgeRef.ref
        .where('isActive', arrayContains: uid)
        .snapshots()
        .map((list) => list.documents.map((doc) => doc).first)
        .first;
    batch.updateData(a.reference, newData);
    return batch;
  }

  static Future<WriteBatch> _setActive(
      WriteBatch batch, String uid, String lodgeId) async {
    var newData = {
      'isActive': FieldValue.arrayUnion([uid]),
    };
    // lodgeRef.ref
    //     .where('id', isEqualTo: lodgeId)
    //     .snapshots()
    //     .listen((data) => data.documents.forEach((doc) {
    //           batch.updateData(doc.reference, newData);
    //           return batch;
    //         }));
    var a = await lodgeRef.ref
        .where('id', isEqualTo: lodgeId)
        .snapshots()
        .map((list) => list.documents.map((doc) => doc).first)
        .first;
    batch.updateData(a.reference, newData);
    return batch;
  }

  static void selectLodge(FirebaseUser user, String lodgeId) async {
    WriteBatch batch = Firestore.instance.batch();

    batch = await _setActive(batch, user.uid, lodgeId);

    batch.commit();
  }

  static void changeLodge(FirebaseUser user, String lodgeId) async {
    WriteBatch batch = Firestore.instance.batch();

    batch = await _setActive(batch, user.uid, lodgeId);
    batch = await _setInactive(batch, user.uid);

    batch.commit();
  }

  static Future<WriteBatch> onSignOut(
      WriteBatch batch, Future<FirebaseUser> user) async {
    FirebaseUser u = await user;

    batch = await _setInactive(batch, u.uid);

    return batch;
  }
}
