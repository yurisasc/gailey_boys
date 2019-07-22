import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> get getUser => _auth.currentUser();
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  /// Function to allow users sign in using their google account.
  /// Separated into three steps:
  ///   1. Use GoogleSignInAccount and GoogleSignInAuthentication
  ///      to obtain credentials.
  ///   2. Get the user from FirebaseUser using the credentials.
  ///   3. Update the data of the user.
  ///
  /// Returns: A logged in user.
  Future<FirebaseUser> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser user = await _auth.signInWithCredential(credential);
      updateUserData(user);

      return user;
    } catch (error) {
      _toastError(error);
      return null;
    }
  }

  /// Function to update the data of the user.
  /// Obtains a reference to the user in the Firestore.
  /// Use merge: true to avoid overwriting the data.
  Future<void> updateUserData(FirebaseUser user) {
    DocumentReference userRef = _db.collection('users').document(user.uid);

    return userRef.setData({
      'uid': user.uid,
      'lastActivity': DateTime.now(),
      'name': user.displayName,
    }, merge: true);
  }

  /// Function to sign out
  Future<void> signOut() {
    return _auth.signOut();
  }

  void _toastError(error) {
    Fluttertoast.showToast(
        msg: error.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
      );
  }
}
