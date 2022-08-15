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
  late List<MemberModel>? _filterMember = [];
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
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 190),
      padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(46),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 30,
            color: Colors.black.withOpacity(0.16),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 2),
          /*const Text(
            "Search by name, email or role",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),*/
          SizedBox(
              width: 1000,
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  hintText: "Search by name, email or role",
                  hintStyle: TextStyle(color: Colors.grey[300]),
                ),
                textAlign: TextAlign.left,
              )),
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
    for (var element in _memberModel!) {
      if (element.name.contains(searchText) || element.email.contains(searchText)
          || element.role.contains(searchText)) {
        _filterMember!.add(element);
      }
    }
    if(_filterMember!.isNotEmpty){
      getListView(_filterMember);
      setState(() { _filterMember!.length; });

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
            padding:
                const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
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
                  "    ",
                  textAlign: TextAlign.start,
                ))),
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
                child: Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          // value: selectedIndexes[index]["value"],
          value: isChecked,
          // value: selectedIndexes.contains(index),
          /*onChanged: (_) {
                            if (selectedIndexes.contains(index)) {
                              selectedIndexes.remove(index);   // unselect
                            } else {
                              selectedIndexes.add(index);  // select
                            }
                          },*/
          onChanged: (bool? value) {
            /*setState(() {
                              isChecked = value!;
                            });*/

            setState(() {
              isChecked = value!;
              /*selectedIndexes[index] = value;
                              if (multipleSelected
                                  .contains(selectedIndexes[index])) {
                                multipleSelected
                                    .remove(selectedIndexes[index]);
                              } else {
                                multipleSelected.add(selectedIndexes[index]);
                              }*/
            });
          },
        ))),
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

/*class _HomeState extends State<HomeScreen> {
  late List<UserModel>? _memberModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _memberModel = (await DataTableApi().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),
      ),
      body: _memberModel == null || _memberModel!.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _memberModel!.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(_memberModel![index].id.toString()),
                    Text(_memberModel![index].username),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(_memberModel![index].email),
                    Text(_memberModel![index].website),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}*/

/*class _HomeState extends State<HomeScreen> {
  late List<MemberModel>? _memberModel = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _memberModel = (await DataTableApi.fetchData());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),
      ),
      body: _memberModel == null || _memberModel!.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _memberModel!.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(_memberModel![index].id.toString()),
                    Text(_memberModel![index].name),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(_memberModel![index].email),
                    Text(_memberModel![index].role),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}*/

/*class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    DataTableApi.fetchData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Flutter - API Implementation"),
      ),
      body: _buildBody(context),
    );
  }

  // build list view & manage states
  FutureBuilder<List<MemberModel>> _buildBody(BuildContext context) {
    final DataTableApi httpService = DataTableApi();

    return FutureBuilder<List<MemberModel>>(
      future: httpService.getMember(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<MemberModel>? posts = snapshot.data;
          return _buildPosts(context, posts!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // build list view & its tile
  ListView _buildPosts(BuildContext context, List<MemberModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index].email),
          ),
        );
      },
    );
  }
}*/

/*
   Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 200.0),
              elevation: 5,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _memberModel!.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                        height: 1.5, color: Color.fromRGBO(36, 11, 54, 1.0)),
                itemBuilder: (context, index) {
                  return SizedBox(height: 60, child: getItem(index));
                },
              ),
            ),
            * */
