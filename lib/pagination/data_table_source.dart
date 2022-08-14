
import 'package:flutter/material.dart';
import 'package:zensar_challenge/ui/main/model/member.dart';

typedef OnRowSelect = void Function(int index);

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    required List<MemberModel> userData,
    required this.onRowSelect,
  })  : _userData = userData,
        assert(userData != null);

  final List<MemberModel> _userData;
  final OnRowSelect onRowSelect;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    if (index >= _userData.length) {
      return null;
    }
    final _user = _userData[index];

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text('${_user.name}')),
        DataCell(Text('${_user.email}')),
        DataCell(Text('${_user.role}')),
        DataCell(
          IconButton(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const Icon(Icons.details),
            onPressed: () => onRowSelect(index),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _userData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(Comparable<T> Function(MemberModel d) getField, bool ascending) {
    _userData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
