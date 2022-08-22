import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zensar_challenge/customwidget/custom_dialog.dart';
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
  late BuildContext dialogContext;
  final myController = TextEditingController();
  int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    myController.addListener(() {});
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
              var dataSource = MemberDataSource(_memberModel!, provider, context);
              return Column(
                children: <Widget>[
                  getSearchView(provider),
                  getDataTable(_memberModel, dataSource),
                ],
              );
            })));
  }

  Widget getDataTable(List<MemberModel>? data, MemberDataSource dataSource) {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: SingleChildScrollView(
              child: PaginatedDataTable(
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
      // color: Colors.blue,
      // margin: const EdgeInsets.only(top: 10, bottom: 10, right: 200, left: 800),
      padding: const EdgeInsets.only(left: 20, right: 0, top: 10, bottom: 10),
      // width: MediaQuery.of(context).size.width,
      // width: double.infinity,
      child: Row(
        children: <Widget>[
          // const SizedBox(width: 20),
          const Spacer(),
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
          const SizedBox(width: 15),
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
              provider.filterData = myController.text;
            },
          ),
          const SizedBox(width: 200),
        ],
      ),
    );
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
            child: Center(
              child: CircularProgressIndicator(),
            ));
      },
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
