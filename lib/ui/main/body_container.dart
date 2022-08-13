import 'package:flutter/material.dart';

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  /*final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];*/

  @override
  Widget build(BuildContext context) {
    return showContainer();
  }

  Widget showSearchView() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 190),
      padding: const EdgeInsets.all(10),
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
          const Text(
            "Search by name, email or role",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          /*TextField(
            onChanged: (value) => _runFilter(value),
            decoration: const InputDecoration(
                labelText: 'Search', suffixIcon: Icon(Icons.search)),
          ),*/
          const Spacer(), //space between search button and text field
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget showContainer() {
    return Column(children: <Widget>[
      const Text('LIST',
          style: TextStyle(
            fontSize: 15.2,
            fontWeight: FontWeight.bold,
          )),
      Expanded(
          child: Container(
        decoration: const BoxDecoration(color: Colors.blue),
        child: ListView(),
      ))
    ]);
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    /*if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }*/

    // Refresh the UI
    /*setState(() {
      _foundUsers = results;
    });*/
  }
}
