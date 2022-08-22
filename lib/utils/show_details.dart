import 'package:flutter/material.dart';
import 'package:zensar_challenge/constant.dart';
import 'package:zensar_challenge/ui/main/model/member.dart';

class ShowDetails extends StatelessWidget {
  ShowDetails({Key? key, required this.data})
      : assert(data != null),
        super(key: key);

  final MemberModel data;

  Iterable<MapEntry<String, String>> get _fieldValues =>
      _onGenerateFields(data).entries;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    for (final field in _fieldValues) {
      if (field.key.toLowerCase() == "name") {
        nameController.value = TextEditingValue(text: field.value);
      } else if (field.key.toLowerCase() == "email") {
        emailController.value = TextEditingValue(text: field.value);
      }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const CloseButton(),
        for (final _fieldValue in _fieldValues) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: _width * 0.1,
                  child: Text(_fieldValue.key),
                ),
                SizedBox(
                  width: _width * 0.1,
                  child: _fieldValue.key.toLowerCase() == "name" ||
                          _fieldValue.key.toLowerCase() == "email"
                      ? TextFormField(
                           controller: _fieldValue.key.toLowerCase() == "name"
                              ? nameController
                              : emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        )
                      : Text(_fieldValue.value.toString()),
                )
              ],
            ),
          ),
        ],
        Row(mainAxisSize: MainAxisSize.min, children: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
             onPressed: () => Navigator.of(context)
                .pop(nameController.text + ";" + emailController.text),
            child: const Text(
              'UPDATE',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ])
      ],
    );
  }

  Map<String, String> _onGenerateFields(MemberModel data) {
    final _fieldValues = {
      colID: data.id.toString(),
      colName: data.name,
      colEmail: data.email,
      colRole: data.role,
    };

    return _fieldValues;
  }
}
