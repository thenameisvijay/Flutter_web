import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:zensar_challenge/constant.dart';
import 'package:zensar_challenge/ui/main/model/member.dart';

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

  static Future<List<MemberModel>> fetchData() async {
    //
    final _completer = Completer<List<MemberModel>>();

    try {
      var uri = Uri.parse(url);
      final resp = await http.get(uri);

      if (resp.statusCode == 200) {
        //
        final _data = memberModelFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      _completer.completeError(<MemberModel>[]);
    }

    return _completer.future;
  }
}
