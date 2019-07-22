import 'package:firebase_auth/firebase_auth.dart';
import 'package:gailey_boys/services/db.dart';
import 'package:gailey_boys/services/models.dart';

/// Static global state
class Global {
  // App data
  static final Map models = {
    User: (data) => User.fromMap(data),
    Post: (data) => Post.fromMap(data),
    Task: (data) => Task.fromMap(data),
    Receipt: (data) => Receipt.fromMap(data),
    Lodge: (data) => Lodge.fromMap(data),
  };

  // Firestore reference for writes
  static final Collection<Lodge> lodgesRef = Collection<Lodge>(path: 'lodges');
  static final UserData<User> userRef = UserData<User>(collection: 'users');
}

/// Static services to query data
class LodgeService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Collection<Lodge> lodgeRef = Collection<Lodge>(path: 'lodges');

  static Future<List<Lodge>> getUserLodge() async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      var snapshots = await lodgeRef.ref
          .where('memberIds', arrayContains: user.uid)
          .getDocuments();
      return snapshots.documents.map((doc) => Lodge.fromMap(doc.data)).toList();
    } else {
      return [];
    }
  }
}