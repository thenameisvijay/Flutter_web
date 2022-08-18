import 'dart:convert';

List<MemberModel> memberModelFromJson(String str) => List<MemberModel>.from(
    json.decode(str).map((x) => MemberModel.fromJson(x)));

String memberModelToJson(List<MemberModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberModel {
  MemberModel(
    this.id,
    this.name,
    this.email,
    this.role,
  );

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'role': role};
  }

  /*factory MemberModel.fromMap(Map map) {
    return MemberModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      role: map['role'],
    );
  }*/

  final String id;
  final String name;
  final String email;
  final String role;

  /*factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json['role'],
      );*/

  /*factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      role: json['role'],
    );
  }*/

  factory MemberModel.fromJson(dynamic json) {
    return MemberModel(json['id'] as String, json['name'] as String, json['name'] as String, json['name'] as String );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
      };
}
