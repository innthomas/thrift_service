import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_service/login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'account_model/account_model.dart';
import 'todo/todo.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(SalesCategoryAdapter());
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Account>(accountBoxName);
  runApp(
    Provider<Account>(
      create: (context) => Account(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thrift Service App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
