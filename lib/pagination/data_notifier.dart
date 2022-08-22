import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zensar_challenge/customwidget/custom_dialog.dart';
import 'package:zensar_challenge/network/api_service.dart';
import 'package:zensar_challenge/ui/main/model/member.dart';
import 'package:zensar_challenge/utils/show_details.dart';

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
      for (var element in memberModel) {
        if (element.name.toLowerCase().contains(searchText) ||
            element.email.toLowerCase().contains(searchText) ||
            element.role.toLowerCase().contains(searchText)) {
          tempSearchList.add(element);
        }
      }

      memberModel.clear();
      memberModel.addAll(tempSearchList);
    } else {
      memberModel.clear();
      memberModel.addAll(completeData);
    }
    notifyListeners();
  }

  set deleteItem(id) {
    memberModel.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> showDetails(BuildContext c, MemberModel data) async {
    final result = showDialog<String>(
      context: c,
      builder: (_) => CustomDialog(
        showPadding: false,
        child: ShowDetails(data: data),
      ),
    );

    result.then((value) {
      var splitStr = value!.split(";");
      memberModel.map((user) {
        final isEditedUser = user == data;
        if (isEditedUser) {
          int index = memberModel.indexWhere((element) => element == user);
          user = user.copy(
              id: data.id,
              name: splitStr[0],
              email: splitStr[1],
              role: data.role);
          memberModel[index] = user;
          notifyListeners();
        }
      }).toList();
    });
    notifyListeners();
  }

  Future<void> fetchData() async {
    completeData = (await ApiService().getMember())!;
    memberModel.addAll(completeData);
    notifyListeners();
  }
}
