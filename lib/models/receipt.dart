import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gailey_boys/models/user.dart';

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
          .toList(),
    );
  }
}
