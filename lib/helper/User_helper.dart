import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

import '../modal.dart';

enum EmployeeTable { id, name, salary, dept, city, gender, exp, contact, email }

class DbHelper {
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();

  Logger logger = Logger();
  String sql = '';
  String dbName = "my_dataBase";
  String tableName = "Employee";

  late Database database;

  Future<void> initDb() async {
    String path = await getDatabasesPath();

    database = await openDatabase(
      "$path/$tableName",
      version: 1,
      onCreate: (db, version) {
        String query =
            """create table if not exists $tableName (${EmployeeTable.id.name} integer primary key autoincrement,
                          ${EmployeeTable.name.name} text not null,
                          ${EmployeeTable.salary.name} real not null,
                          ${EmployeeTable.dept.name} text,
                          ${EmployeeTable.city.name} text,
                          ${EmployeeTable.gender.name} text,
                          ${EmployeeTable.exp.name} text not null,
                          ${EmployeeTable.contact.name} text unique,
                          ${EmployeeTable.email.name} text unique
                          )""";

        db
            .execute(query)
            .then(
              (value) => logger.i("Table Create successfully"),
            )
            .onError(
              (error, stackTrace) => logger.e("ERROR : $error"),
            );
      },
    );
  }

  Future<void> insertData({required Employee employee}) async {
    sql =
        "insert into $tableName(name,salary,dept,city,gender,exp,contact,email) values(?,?,?,?,?,?,?,?)";
    List args = [
      employee.name,
      employee.salary,
      employee.dept,
      employee.city,
      employee.gender,
      employee.exp,
      employee.contact,
      employee.email
    ];
    await database.rawInsert(sql, args);
  }

  Future<void> updataData({required Employee employee}) async {
    await database
        .update(tableName, employee.getEmployee, where: 'id = ${employee.id}')
        .then(
          (value) => logger.i('updated'),
        )
        .onError((error, stackTrace) => 'error : $error');

    sql = update 
  }

  Future<void> deleteData({required Employee employee}) async {
    await database
        .delete(
          tableName,
          where: "id=?",
          whereArgs: [employee.id],
        )
        .then(
          (value) => logger.i('Deleted'),
        )
        .onError(
          (error, stackTrace) => logger.e('Error : $error'),
        );
  }

  Future<List<Employee>> getAllData() async {
    List<Employee> allEmployee = [];

    sql = "select * from $tableName;";
    List Data = await database.rawQuery(sql);
    allEmployee = Data.map((e) => Employee.fromSQL(data: e)).toList();

    return allEmployee;
  }

  Future<List<Employee>> searchData({required value}) async {
    sql = "select * from $tableName where name like '%$value%';";
    List Data = await database.rawQuery(sql);
    return Data.map((e) => Employee.fromSQL(data: e)).toList();
  }
}
