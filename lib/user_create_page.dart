import 'package:flutter/material.dart';
import 'package:flutter_mongo_example/db_helper/mongodb.dart';
import 'package:flutter_mongo_example/user_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class UserCreatePage extends StatefulWidget {
  const UserCreatePage({Key? key}) : super(key: key);

  @override
  State<UserCreatePage> createState() => _UserCreatePageState();
}

class _UserCreatePageState extends State<UserCreatePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextField(
          decoration: const InputDecoration(hintText: "Username", filled: true),
          controller: usernameController,
        ),
        TextField(
          decoration: const InputDecoration(hintText: "Password", filled: true),
          controller: passwordController,
        ),
        ElevatedButton(
            onPressed: () {
              insertUser(usernameController.text, passwordController.text);
            },
            child: const Text("Insert"))
      ]),
    );
  }

  Future<void> insertUser(String username, String password) async {
    var id = mongo.ObjectId();
    final data = UserModel(id: id, name: username, password: password);
    var result = await MongoDatabase.insert(data);
  }
}
