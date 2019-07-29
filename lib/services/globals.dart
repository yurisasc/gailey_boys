import 'package:flutter/material.dart';
import 'package:gailey_boys/models/models.dart';
import 'package:gailey_boys/services/db.dart';
import 'package:gailey_boys/services/strings.dart';

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

  static final Map actionItemsIcon = {
    Strings.action_changeLodge: Icons.view_agenda,
    Strings.action_settings: Icons.settings,
  };

  // Firestore reference for writes
  static final Collection<Lodge> lodgesRef = Collection<Lodge>(path: 'lodges');
  static final UserData<User> userRef = UserData<User>(collection: 'users');
}
