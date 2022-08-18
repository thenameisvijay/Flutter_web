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

  int get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }

  set rowsPerPage(int rowsPerPage) {
    _rowsPerPage = rowsPerPage;
    notifyListeners();
  }

  set filterData(String searchText) {
    if (searchText.isNotEmpty) {
      List<MemberModel> tempSearchList = <MemberModel>[];
      for (var element in memberModel) {
        if (element.name.toLowerCase().contains(searchText) ||
            element.email.toLowerCase().contains(searchText) ||
            element.role.toLowerCase().contains(searchText)) {
          tempSearchList.add(element);
        }
      }
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

  deleteItem(id){
    print('Print User Id is- ${id}');
    completeData.remove(id);
    notifyListeners();
  }

  editItem(){
    String objText = '{"id":"1", "name": "bezkoder", "email": "vijay@zensar.com", "role":"admin"}';
    MemberModel user = MemberModel.fromJson(jsonDecode(objText));
    memberModel[memberModel.indexWhere((element) => element.id == user.id)];
    notifyListeners();
  }

  Future<void> fetchData() async {
    completeData = (await ApiService().getMember())!;
    memberModel.addAll(completeData);
    notifyListeners();
  }

  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  bool get sortAscending => _sortAscending;

  int get rowsPerPage => _rowsPerPage;
}
