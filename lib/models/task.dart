import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gailey_boys/models/user.dart';

class Task {
  String id;
  String creatorId;
  String name;
  String desc;
  List<User> contributors;
  Timestamp createdDate;
  Timestamp dueDate;

  Task(
      {this.id,
      this.creatorId,
      this.name,
      this.desc,
      this.contributors,
      this.createdDate,
      this.dueDate});

  factory Task.fromMap(Map data) {
    return Task(
      id: data['id'],
      creatorId: data['creator'],
      name: data['name'],
      desc: data['description'],
      contributors: (data['contributors'] as List ?? [])
          .map((v) => User.fromMap(v))
          .toList(),
      createdDate: data['created_date'],
    );
  }
}