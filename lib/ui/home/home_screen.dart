import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zensar_challenge/constant.dart';
import 'package:zensar_challenge/network/api_service.dart';
import 'package:zensar_challenge/ui/main/model/member.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late List<MemberModel>? _memberModel = [];
  late final List<MemberModel>? _filterMember = [];
  bool isChecked = false;
  var selectedIndexes = [];
  List multipleSelected = [];
  late BuildContext dialogContext;
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _memberModel = (await ApiService().getMember())!;
    _filterMember!.addAll(_memberModel!);
    Future.delayed(defaultDuration).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromRGBO(195, 20, 50, 1.0),
              Color.fromRGBO(36, 11, 54, 1.0)
            ])),
        child: initView());
  }

  Widget initView() {
    return Scaffold(
        // By default, Scaffold background is white
        // Set its value to transparent
        backgroundColor: Colors.transparent,
        body: _memberModel == null || _memberModel!.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  getSearchView(),
                  getRowHeader(),
                  getListView(_memberModel)
                ],
              ));
  }

  Widget getListView(List<MemberModel>? memberModel) {
    return Expanded(
        child: Card(
      margin: const EdgeInsets.only(left: 200.0, right: 200.0, bottom: 150.0),
      elevation: 5,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: memberModel!.length,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1.5, color: Color.fromRGBO(36, 11, 54, 1.0)),
        itemBuilder: (context, index) {
          return SizedBox(height: 60, child: getItem(index, memberModel));
        },
      ),
    ));
  }

  Widget getSearchView() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 200, left: 800),
      padding: const EdgeInsets.only(left: 20, right: 0, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 20),
          /*const Text(
            "Search by name, email or role",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),*/
          SizedBox(
              width: 500,
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Search by name, email or role",
                    hintStyle: TextStyle(color: Colors.grey[300], fontSize: 19),
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                textAlign: TextAlign.left,
              )),
          const SizedBox(width: 30),
          MaterialButton(
            height: 50.0,
            minWidth: 100.0,
            color: Colors.red,
            child: const Text(
              "Search",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            onPressed: () {
              searchInList(myController.text);
            },
          ),
        ],
      ),
    );
  }

  void searchInList(String searchText) {
    if (searchText.isNotEmpty) {
      List<MemberModel> tempSearchList = <MemberModel>[];
      // if (_memberModel!.isEmpty) {
      _memberModel!.clear();
      _memberModel!.addAll(_filterMember!);
      // }
      for (var element in _memberModel!) {
        if (element.name.toLowerCase().contains(searchText) ||
            element.email.toLowerCase().contains(searchText) ||
            element.role.toLowerCase().contains(searchText)) {
          tempSearchList.add(element);
        }
      }
      if (tempSearchList.isNotEmpty) {
        getListView(tempSearchList);
        // _filterMember!.addAll(_memberModel!);
        Future.delayed(defaultDuration).then((value) => setState(() {
              _memberModel!.clear();
              _memberModel!.addAll(tempSearchList);
            }));
      } else {
        /*ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No Data Found!")));*/

        Timer? timer = Timer(const Duration(milliseconds: 2000), () {
          Navigator.of(context, rootNavigator: true).pop();
        });
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("No Data Found!"),
              );
            }).then((value) {
          // dispose the timer in case something else has triggered the dismiss.
          timer?.cancel();
          timer = null;
        });
      }
    }
  }

  Future<dynamic> showCircularLoader() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        dialogContext = context;
        return const Dialog(
            backgroundColor: Colors.transparent,
            // Retrieve the text that the user has entered by using the
            // TextEditingController.
            // content: Text(myController.text),
            child: Center(
              child: CircularProgressIndicator(),
            ));
      },
    );
  }

  Widget getItem(int index, List<MemberModel>? memberModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      //Center Row contents horizontally,
      children: [
        const SizedBox(
          height: 5.0,
        ),
        getMemberDetail(index, memberModel),
        const SizedBox(
          height: 5.0,
        ),
      ],
    );
  }

  Widget getRowHeader() {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 200),
        child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -2),
                  blurRadius: 30,
                  color: Colors.black.withOpacity(0.16),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              //Center Row contents vertically,
              children: const [
                Expanded(
                    child: Center(
                        child: Text(
                  "Name",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 21),
                ))),
                Expanded(
                    child: Center(
                        child: Text(
                  "Email",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 21),
                ))),
                Expanded(
                    child: Center(
                        child: Text(
                  "Role",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 21),
                ))),
              ],
            )));
  }

  Widget getMemberDetail(int index, List<MemberModel>? memberModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      //Center Row contents vertically,
      children: [
        Expanded(
            child: Center(
                child: Text(
          _memberModel![index].name,
          textAlign: TextAlign.start,
        ))),
        Expanded(
            child: Center(
                child: Text(
          _memberModel![index].email,
          textAlign: TextAlign.start,
        ))),
        Expanded(
            child: Center(
                child: Text(
          _memberModel![index].role,
          textAlign: TextAlign.start,
        ))),
      ],
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.grey;
    }
    return Colors.red;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
}
