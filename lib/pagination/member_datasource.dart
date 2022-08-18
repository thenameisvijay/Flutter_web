import 'package:flutter/material.dart';
import 'package:zensar_challenge/pagination/data_notifier.dart';
import 'package:zensar_challenge/ui/main/model/member.dart';

class MemberDataSource extends DataTableSource {
  List<MemberModel>  memberModel;
  UserDataNotifier provider;
  MemberDataSource(this.memberModel, this.provider);
  
  @override
  DataRow getRow(int index){
    return DataRow.byIndex(index: index,  cells: [
      DataCell(Text(memberModel[index].id)),
      DataCell(Text(memberModel[index].name)),
      DataCell(Text(memberModel[index].email)),
      DataCell(Text(memberModel[index].role)),
      DataCell(const Icon(Icons.delete,color:Colors.black),
          onTap: () {
            provider.deleteItem(memberModel[index].id);
          }),
      const DataCell(Icon(Icons.edit,color:Colors.black)),
    ]);
  }
  @override
  bool get isRowCountApproximate => true;
  @override
  int get rowCount => memberModel.length;
  @override
  int get selectedRowCount => 0;
}