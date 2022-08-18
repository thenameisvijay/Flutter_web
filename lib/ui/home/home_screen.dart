import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zensar_challenge/constant.dart';
import 'package:zensar_challenge/network/api_service.dart';
import 'package:zensar_challenge/pagination/data_notifier.dart';
import 'package:zensar_challenge/pagination/member_datasource.dart';
import 'package:zensar_challenge/ui/main/model/member.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late List<MemberModel>? _memberModel = [];
  late List<MemberModel>? pageList = [];
  late final List<MemberModel>? _filterMember = [];
  bool isChecked = false;
  var selectedIndexes = [];
  List multipleSelected = [];
  late BuildContext dialogContext;
  final myController = TextEditingController();
  int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    // _getData();
    myController.addListener(() {});
  }

  void _getData() async {
    _memberModel = (await ApiService().getMember())!;
    pageList = _memberModel!.sublist(0, 10);
    _filterMember!.addAll(_memberModel!);
    // print("Size${test.length}");
    Future.delayed(defaultDuration).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // final _provider = context.watch<UserDataNotifier>();

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

  /*Widget initView() {
    return Scaffold(
        // By default, Scaffold background is white
        // Set its value to transparent
        backgroundColor: Colors.transparent,
        body: pageList == null || pageList!.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  getSearchView(),
                  // getRowHeader(),
                  // getListView(pageList),
                  getDataTable(pageList),
                ],
              ));
  }*/

  Widget initView() {
    return Scaffold(
        // By default, Scaffold background is white
        // Set its value to transparent
        backgroundColor: Colors.transparent,
        body: ChangeNotifierProvider<UserDataNotifier>(
            create: (context) => UserDataNotifier(),
            child:
                Consumer<UserDataNotifier>(builder: (context, provider, child) {
              if (provider.userModel == null) {
                provider.fetchData();
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              _memberModel = provider.userModel;
              var dataSource = MemberDataSource(_memberModel!, provider);
              return Column(
                children: <Widget>[
                  getSearchView(provider),
                  // getRowHeader(),
                  // getListView(pageList),
                  getDataTable(_memberModel, provider, dataSource),
                ],
              );
            })));
  }

  Widget getDataTable(List<MemberModel>? data, UserDataNotifier provider,
      MemberDataSource dataSource) {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            // height: MediaQuery.of(context).size.width * 0.40,
            child: SingleChildScrollView(
              child: PaginatedDataTable(
                // columnSpacing: 155.0,
                columns: const [
                  DataColumn(
                    label: Text('ID', style: TextStyle(fontSize: 21)),
                    tooltip: 'Person ID',
                  ),
                  DataColumn(
                      label: Text('Name', style: TextStyle(fontSize: 21)),
                      tooltip: 'Person Name'),
                  DataColumn(
                      label: Text('Email', style: TextStyle(fontSize: 21)),
                      tooltip: 'Person Email'),
                  DataColumn(
                      label: Text('Role', style: TextStyle(fontSize: 21)),
                      tooltip: 'Role of the person'),
                  DataColumn(
                      label: Text('Delete', style: TextStyle(fontSize: 21)),
                      tooltip: 'Delete Person'),
                  DataColumn(
                      label: Text('Edit', style: TextStyle(fontSize: 21)),
                      tooltip: 'Edit Person Details'),
                ],
                source: dataSource,
                onRowsPerPageChanged: (r) {
                  setState(() {
                    _rowPerPage = r!;
                  });
                },
                rowsPerPage: _rowPerPage,
              ),
            )));
  }

  Widget getSearchView(UserDataNotifier provider) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 200, left: 800),
      padding: const EdgeInsets.only(left: 20, right: 0, top: 10, bottom: 10),
      // width: MediaQuery.of(context).size.width * 0.75,
      child: Row(
        children: <Widget>[
          const SizedBox(width: 20),
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
                onChanged: (text) {
                  if (text.isEmpty) {
                    provider.filterData = myController.text;
                  }
                },
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
              // searchInList(myController.text);
              provider.filterData = myController.text;
            },
          ),
        ],
      ),
    );
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
