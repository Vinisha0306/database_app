import 'package:database_app/helper/User_helper.dart';
import 'package:database_app/modal.dart';
import 'package:flutter/material.dart';

class DbController extends ChangeNotifier {
  List<Employee> allEmployeeData = [];
  List<Employee> allSearchData = [];

  DbController() {
    initData();
  }

  Future<void> initData() async {
    DbHelper.dbHelper.initDb();
    allEmployeeData = await DbHelper.dbHelper.getAllData();
    print(allEmployeeData[0].name);
    notifyListeners();
  }

  void insertData({required Employee employee}) {
    DbHelper.dbHelper.insertData(employee: employee);
    initData();
  }

  void deleteData({required Employee employee}) {
    DbHelper.dbHelper.deleteData(employee: employee);
    initData();
  }

  void updateData({required Employee employee}) {
    DbHelper.dbHelper.updataData(employee: employee);
    initData();
  }

  Future<void> searchData({required Employee employee}) async {
    allSearchData = await DbHelper.dbHelper.searchData(value: employee.name);
    initData();
  }
}
