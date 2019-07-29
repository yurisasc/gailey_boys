import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gailey_boys/models/lodge.dart';

class User {
  String name;
  String uid;
  String img;
  String activeLodge;
  Timestamp lastActivity;
  List<Lodge> lodges;

  double amountPaid;
  bool isAdmin;

  User(
      {this.name,
      this.uid,
      this.img,
      this.activeLodge,
      this.lastActivity,
      this.lodges,
      this.amountPaid,
      this.isAdmin});

  factory User.fromMap(Map data) {
    return User(
      uid: data['uid'] ?? '',
      name: data['user_name'] ?? '',
      img: data['user_img'] ?? '',
      activeLodge: data['activeLodge'],
      lastActivity: data['lastActivity'],
      lodges:
          (data['lodges'] as List ?? []).map((v) => Lodge.fromMap(v)).toList(),
      amountPaid: data['amountPaid'],
      isAdmin: data['isAdmin'],
    );
  }

  // factory User.fromSnapshot(DocumentSnapshot snapshot) {
  //   User.fromMap(snapshot.data);
  // }
}