import 'package:database_app/pages/homepage/update_fild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/DbController.dart';
import '../../modal.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List allData = [
    'Id',
    'Name',
    'Salary',
    'Dept',
    'City',
    'Gender',
    'Exp',
    'Contact',
    'Email'
  ];

  int id = 0;
  String name = '';
  double salary = 0.0;
  String dept = '';
  String city = '';
  String gender = '';
  String exp = '';
  String contact = '';
  String email = '';

  late TabController tabController;
  PageController pageController = PageController();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DbController listanble = Provider.of<DbController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        bottom: TabBar(
          controller: tabController,
          onTap: (value) => pageController.animateToPage(value,
              duration: Duration(milliseconds: 200), curve: Curves.bounceIn),
          tabs: const [
            Text('All Employees'),
            Text('Search Employees'),
          ],
        ),
      ),
      body: PageView.builder(
        itemCount: 2,
        controller: pageController,
        onPageChanged: (value) => tabController.animateTo(value),
        itemBuilder: (context, index) => index == 0
            ? Provider.of<DbController>(context).allEmployeeData.isEmpty
                ? Center(
                    child: ListView.builder(
                      itemBuilder: (context, index) => const ListTile(
                        tileColor: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: Provider.of<DbController>(context)
                        .allEmployeeData
                        .length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Text(Provider.of<DbController>(context)
                          .allEmployeeData[index]
                          .name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: AlertDialog(
                                    title:
                                        const Text('Update Employee Details'),
                                    actions: [
                                      TextFormField(
                                        initialValue:
                                            '${listanble.allEmployeeData[index].id}',
                                        onChanged: (val) {
                                          id = val as int;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Id',
                                        ),
                                      ),
                                      UpdateFild(
                                          initialValue: listanble
                                              .allEmployeeData[index].name,
                                          onChanged: (val) {
                                            name = val;
                                          },
                                          title: 'Name'),
                                      TextFormField(
                                        initialValue:
                                            '${listanble.allEmployeeData[index].salary}',
                                        onChanged: (val) {
                                          salary = val as double;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Salary',
                                        ),
                                      ),
                                      UpdateFild(
                                          initialValue: listanble
                                              .allEmployeeData[index].dept,
                                          onChanged: (val) {
                                            dept = val;
                                          },
                                          title: 'Dept'),
                                      UpdateFild(
                                          initialValue: listanble
                                              .allEmployeeData[index].city,
                                          onChanged: (val) {
                                            city = val;
                                          },
                                          title: 'City'),
                                      UpdateFild(
                                          initialValue: listanble
                                              .allEmployeeData[index].gender,
                                          onChanged: (val) {
                                            gender = val;
                                          },
                                          title: 'Gender'),
                                      UpdateFild(
                                          initialValue: listanble
                                              .allEmployeeData[index].exp,
                                          onChanged: (val) {
                                            exp = val;
                                          },
                                          title: 'Exp'),
                                      UpdateFild(
                                          initialValue: listanble
                                              .allEmployeeData[index].contact,
                                          onChanged: (val) {
                                            contact = val;
                                          },
                                          title: 'Contact'),
                                      UpdateFild(
                                          initialValue: listanble
                                              .allEmployeeData[index].email,
                                          onChanged: (val) {
                                            email = val;
                                          },
                                          title: 'Email'),
                                      OutlinedButton(
                                        onPressed: () {
                                          Provider.of<DbController>(context,
                                                  listen: false)
                                              .updateData(
                                            employee: Employee(
                                                id,
                                                name,
                                                salary,
                                                dept,
                                                city,
                                                gender,
                                                exp,
                                                contact,
                                                email),
                                          );
                                          print('name : $name');
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Save',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              Provider.of<DbController>(context, listen: false)
                                  .deleteData(
                                employee: Employee(id, name, salary, dept, city,
                                    gender, exp, contact, email),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
            : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => ListTile(),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => SingleChildScrollView(
              child: AlertDialog(
                title: const Text('Add Employee Details'),
                actions: [
                  ...List.generate(
                    allData.length,
                    (index) => TextFormField(
                      onChanged: (val) {
                        if (index == 0) id = val as int;
                        if (index == 1) name = val;
                        if (index == 2) salary = val as double;
                        if (index == 3) dept = val;
                        if (index == 4) city = val;
                        if (index == 5) gender = val;
                        if (index == 6) exp = val;
                        if (index == 7) contact = val;
                        if (index == 8) email = val;
                      },
                      decoration: InputDecoration(
                        labelText: allData[index],
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Provider.of<DbController>(context, listen: false)
                          .insertData(
                              employee: Employee(id, name, salary, dept, city,
                                  gender, exp, contact, email));
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Save',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
