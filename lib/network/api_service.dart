import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:zensar_challenge/ui/main/model/member.dart';
import 'package:zensar_challenge/constant.dart';
import 'package:zensar_challenge/ui/main/model/user_model.dart';

class ApiService {

  Future<List<MemberModel>?> getMember() async {
    try {
      var uri = Uri.parse(url);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        List<MemberModel> _model = memberModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
      return List.empty();
    }
  }

  Future<List<UserModel>?> getUsers() async {
    try {
      var url = Uri.parse(new_url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<UserModel> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}