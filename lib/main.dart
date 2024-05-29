import 'package:database_app/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/DbController.dart';
import 'helper/User_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDb();
  runApp(
    ChangeNotifierProvider(
      create: (context) => DbController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Data base'),
    );
  }
}
