import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:zensar_challenge/constant.dart';
import 'package:zensar_challenge/customwidget/custom_scaffold.dart';
import 'package:zensar_challenge/pagination/custom_paginated_table.dart';
import 'package:zensar_challenge/pagination/data_notifier.dart';
import 'package:zensar_challenge/pagination/data_table_source.dart';
import 'package:zensar_challenge/ui/main/model/member.dart';

class DataTableScreen extends StatelessWidget {
  const DataTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return CustomScaffold(
      showDrawer: true,
      /*drawerChild: CustomDrawer(
        medium: DataTableConstants.medium,
        youtubeLink: DataTableConstants.youtube,
        website: DataTableConstants.website,
      ),*/
      enableDarkMode: true,
      titleText: dtTitle,
      child: ChangeNotifierProvider<UserDataNotifier>(
        create: (_) => UserDataNotifier(),
        child: _InternalWidget(),
      ),
    );
  }
}

class _InternalWidget extends StatelessWidget {
  const _InternalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final _provider = context.watch<UserDataNotifier>();
    final _model = _provider.userModel;

    if (_model.isEmpty) {
      return const SizedBox.shrink();
    }
    final _dtSource = UserDataTableSource(
      onRowSelect: (index) => _showDetails(context, _model[index]),
      userData: _model,
    );

    return CustomPaginatedTable(
      actions: <IconButton>[
        IconButton(
          splashColor: Colors.transparent,
          icon: const Icon(Icons.refresh),
          onPressed: () {
            _provider.fetchData();
            _showSBar(context, refresh);
          },
        ),
      ],
      dataColumns: _colGen(_dtSource, _provider),
      header: const Text(users),
      onRowChanged: (index) => _provider.rowsPerPage = index!,
      rowsPerPage: _provider.rowsPerPage,
      showActions: true,
      source: _dtSource,
      sortColumnIndex: _provider.sortColumnIndex,
      sortColumnAsc: _provider.sortAscending,
    );
  }

  List<DataColumn> _colGen(
    UserDataTableSource _src,
    UserDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: const Text(colName),
          tooltip: colName,
          onSort: (colIndex, asc) {
            _sort<String>((user) => user.name, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: const Text(colEmail),
          tooltip: colEmail,
          onSort: (colIndex, asc) {
            _sort<String>((user) => user.email, colIndex, asc, _src, _provider);
          },
        ),DataColumn(
          label: const Text(colRole),
          tooltip: colRole,
          onSort: (colIndex, asc) {
            _sort<String>((user) => user.role, colIndex, asc, _src, _provider);
          },
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(MemberModel user) getField,
    int colIndex,
    bool asc,
    UserDataTableSource _src,
    UserDataNotifier _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  void _showSBar(BuildContext c, String textToShow) {
    ScaffoldMessenger.of(c).showSnackBar(
      SnackBar(
        content: Text(textToShow),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }

  void _showDetails(BuildContext c, MemberModel data) {

  }

  /*void _showDetails(BuildContext c, MemberModel data) async =>
      await showDialog<bool>(
        context: c,
        builder: (_) => CustomDialog(
          showPadding: false,
          child: OtherDetails(data: data),
        ),
      );*/
}
