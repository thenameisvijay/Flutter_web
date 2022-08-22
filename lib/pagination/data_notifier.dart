import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:zensar_challenge/network/api_service.dart';
import 'package:zensar_challenge/ui/main/model/member.dart';

class UserDataNotifier with ChangeNotifier {
  UserDataNotifier() {
    fetchData();
  }

  var completeData = <MemberModel>[];
  var memberModel = <MemberModel>[];

  List<MemberModel> get userModel => memberModel;

  set filterData(String searchText) {
    if (searchText.isNotEmpty) {
      List<MemberModel> tempSearchList = <MemberModel>[];
      /*for (var element in memberModel) {
        if (element.name.toLowerCase().contains(searchText) ||
            element.email.toLowerCase().contains(searchText) ||
            element.role.toLowerCase().contains(searchText)) {
          tempSearchList.add(element);
        }
      }*/

      for (int i = 0; i < memberModel.length; i++) {
        var element = memberModel[i];
        if (element.name.toLowerCase().contains(searchText) ||
            element.email.toLowerCase().contains(searchText) ||
            element.role.toLowerCase().contains(searchText)) {
          tempSearchList.add(element);
        }
      }
      // print('memberModel is ${memberModel.length}');
      // print('tempSearchList ${tempSearchList.length}');
      memberModel.clear();
      if (tempSearchList.isNotEmpty) {
        memberModel.addAll(tempSearchList);
      }
    } else {
      memberModel.clear();
      memberModel.addAll(completeData);
    }
    notifyListeners();
  }

  set deleteItem(id) {
    print('Print User Id is- ${id}');
    memberModel.remove(id);
    notifyListeners();
  }

  editItem() {
    String objText =
        '{"id":"1", "name": "bezkoder", "email": "vijay@zensar.com", "role":"admin"}';
    MemberModel user = MemberModel.fromJson(jsonDecode(objText));
    memberModel[memberModel.indexWhere((element) => element.id == user.id)];
    notifyListeners();
  }

  Future<void> fetchData() async {
    completeData = (await ApiService().getMember())!;
    memberModel.addAll(completeData);
    notifyListeners();
  }
}
