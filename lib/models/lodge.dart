import 'package:gailey_boys/models/user.dart';

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