import 'package:flutter/material.dart';
import 'package:flutter_mongo_example/widgets/custom_button.dart';
import 'package:flutter_mongo_example/widgets/custom_text_field.dart';
import 'package:flutter_mongo_example/db_helper/mongodb.dart';
import 'package:flutter_mongo_example/models/user_model.dart';
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
        CustomTextField(controller: usernameController, hintText: "Username"),
        CustomTextField(controller: passwordController, hintText: "Password"),
        CustomButton(
            onPressed: () {
              insertUser(usernameController.text, passwordController.text)
                  .then((value) => Navigator.pop(context));
            },
            buttonTitle: "Insert")
      ]),
    );
  }

  Future<void> insertUser(String username, String password) async {
    var id = mongo.ObjectId();
    final data = UserModel(id: id, name: username, password: password);
    await MongoDatabase.insert(data);
  }
}
