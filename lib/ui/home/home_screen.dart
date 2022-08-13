import 'package:flutter/material.dart';
import 'package:zensar_challenge/network/api_service.dart';
import 'package:zensar_challenge/ui/main/model/member.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late List<MemberModel>? _userModel = [];
  bool isChecked = false;
  var selectedIndexes = [];
  List multipleSelected = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await ApiService().getMember())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
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
        child: Scaffold(
          // By default, Scaffold background is white
          // Set its value to transparent
          backgroundColor: Colors.transparent,
          body: _userModel == null || _userModel!.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 200.0),
                  elevation: 5,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _userModel!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                            height: 1.5,
                            color: Color.fromRGBO(36, 11, 54, 1.0)),
                    itemBuilder: (context, index) {
                      return SizedBox(height: 60, child: getItem(index));
                    },
                  ),
                ),
        ));
  }

  Widget getItem(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      //Center Row contents horizontally,
      children: [
        const SizedBox(
          height: 5.0,
        ),
        getMemberDetail(index),
        const SizedBox(
          height: 5.0,
        ),
      ],
    );
  }

  Widget getMemberDetail(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      //Center Row contents vertically,
      children: [
        Container(
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
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            _userModel![index].name,
            textAlign: TextAlign.start,
          ),
        ),
        Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              _userModel![index].email,
              textAlign: TextAlign.start,
            )),
        Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              _userModel![index].role,
              textAlign: TextAlign.start,
            )),
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
}

/*class _HomeState extends State<HomeScreen> {
  late List<UserModel>? _userModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await DataTableApi().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),
      ),
      body: _userModel == null || _userModel!.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _userModel!.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(_userModel![index].id.toString()),
                    Text(_userModel![index].username),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(_userModel![index].email),
                    Text(_userModel![index].website),
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
  late List<MemberModel>? _userModel = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await DataTableApi.fetchData());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),
      ),
      body: _userModel == null || _userModel!.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _userModel!.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(_userModel![index].id.toString()),
                    Text(_userModel![index].name),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(_userModel![index].email),
                    Text(_userModel![index].role),
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
