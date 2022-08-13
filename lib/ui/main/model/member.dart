import 'dart:convert';

List<MemberModel> memberModelFromJson(String str) => List<MemberModel>.from(
    json.decode(str).map((x) => MemberModel.fromJson(x)));

String memberModelToJson(List<MemberModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberModel {
  MemberModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  String id;
  String name;
  String email;
  String role;

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json['role'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
      };
}
