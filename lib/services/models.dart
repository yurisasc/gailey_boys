import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String uid;
  String img;
  Timestamp lastActivity;
  List<Lodge> lodges;

  double amountPaid;
  bool isAdmin;

  User(
      {this.name,
      this.uid,
      this.img,
      this.lastActivity,
      this.lodges,
      this.amountPaid,
      this.isAdmin});

  factory User.fromMap(Map data) {
    return User(
      uid: data['uid'] ?? '',
      name: data['user_name'] ?? '',
      img: data['user_img'] ?? '',
      lastActivity: data['lastActivity'],
      lodges:
          (data['lodges'] as List ?? []).map((v) => Lodge.fromMap(v)).toList(),
      amountPaid: data['amountPaid'],
      isAdmin: data['isAdmin'],
    );
  }
}

class Post {
  String id;
  String senderName;
  String senderImg;
  String senderId;
  DateTime timeStamp;
  String msg;

  Post(
      {this.id,
      this.senderName,
      this.senderImg,
      this.senderId,
      this.timeStamp,
      this.msg});

  factory Post.fromMap(Map data) {
    return Post(
      id: data['id'],
      msg: data['message'],
      timeStamp: data['timestamp'],
      senderId: data['user_id'],
      senderName: data['user_name'],
      senderImg: data['user_img'],
    );
  }
}

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

class Receipt {
  String id;
  String name;
  double price;
  double amountPaid;
  String img;
  Timestamp createdDate;
  List<User> contributions;

  Receipt(
      {this.id,
      this.name,
      this.price,
      this.amountPaid,
      this.img,
      this.createdDate,
      this.contributions});

  factory Receipt.fromMap(Map data) {
    return Receipt(
        id: data['id'],
        amountPaid: data['amountPaid'],
        price: data['total_price'],
        name: data['name'],
        createdDate: data['created_date'],
        img: data['receipt_img'],
        contributions: (data['contributions'] as List ?? [])
            .map((v) => User.fromMap(v))
            .toList());
  }
}

class Lodge {
  String id;
  List<String> admins;
  List<User> members;
  String img;
  String name;
  String topContributor;
  String totalSpending;

  Lodge(
      {this.id,
      this.admins,
      this.members,
      this.name,
      this.topContributor,
      this.totalSpending});

  factory Lodge.fromMap(Map data) {
    return Lodge(
      id: data['id'],
      admins: (data['admins'] as List ?? []).map((v) => '$v').toList(),
      members:
          (data['members'] as List ?? []).map((v) => User.fromMap(v)).toList(),
      name: data['name'],
      topContributor: data['top_contributor'],
      totalSpending: data['totalSpending'],
    );
  }
}
