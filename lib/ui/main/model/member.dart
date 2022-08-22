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

  String id;
  String name;
  String email;
  String role;

  factory MemberModel.fromJson(dynamic json) {
    return MemberModel(json['id'] as String, json['name'] as String,
        json['email'] as String, json['role'] as String);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
      };

  MemberModel copy({
    required String id,
    required String name,
    required String email,
    required String role,
  }) =>
      MemberModel(
        id,
        name,
        email,
        role,
      );
}
