import 'package:flutter/material.dart';
import 'package:flutter_mongo_example/db_helper/mongodb.dart';
import 'package:flutter_mongo_example/pages/user_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
        ),
        primarySwatch: Colors.blue,
      ),
      home: const UserListPage(),
    );
  }
}
