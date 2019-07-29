import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gailey_boys/blocs/lodge_bloc.dart';
import 'package:gailey_boys/models/models.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  SelectedLodge
}

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();

  static Status _status = Status.Uninitialized;
  static Lodge activeLodge;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserRepository.instance() : _auth = FirebaseAuth.instance {
    LodgeService.activeLodgeStream().listen(onLodgeStateChanged);
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;

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
      _status = Status.Authenticating;
      notifyListeners();

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
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      _toastError(e);
      return null;
    }
  }

  Future signOut() async {
    WriteBatch batch = Firestore.instance.batch();
    batch = await LodgeService.onSignOut(batch, getUser);

    await batch.commit();

    _status = Status.Unauthenticated;
    notifyListeners();

    await _auth.signOut();

    return Future.delayed(Duration.zero);
  }

  Future<void> onLodgeStateChanged(Lodge lodge) async {
    if (lodge != null) {
      _status = Status.SelectedLodge;
    } else {
      // TODO: Masa langsung authenticated?
      // ini buat ngehandle kalo isActive tiba2 ilang / logout
      _status = Status.Unauthenticated;
    }
    activeLodge = lodge;
    notifyListeners();
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      // TODO: masi ada bug disini, kadang pergi ke Timeline meskipun belom milih lodge
      _status = await LodgeService.activeLodgeStream().first == null
          ? Status.Authenticated
          : Status.SelectedLodge;
    }
    notifyListeners();
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

  void _toastError(error) {
    Fluttertoast.showToast(
      msg: error.message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
    );
  }
}
