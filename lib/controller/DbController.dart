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

  Future<void> updateData({required Employee employee, required int id}) async {
    await DbHelper.dbHelper.updataData(employee: employee, id: id);
    initData();
  }

  Future<void> searchData({required String value}) async {
    allSearchData = await DbHelper.dbHelper.searchData(value: value);
    initData();
  }
}
