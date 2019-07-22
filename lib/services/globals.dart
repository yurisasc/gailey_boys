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
  };

  // Firestore reference for writes
  static final UserData<User> userRef = UserData<User>(collection: 'users');
}