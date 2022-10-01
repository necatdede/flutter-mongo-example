import 'package:flutter/material.dart';
import 'package:flutter_mongo_example/validator/validator.dart';
import 'package:flutter_mongo_example/widgets/custom_button.dart';
import 'package:flutter_mongo_example/widgets/custom_text_field.dart';
import 'package:flutter_mongo_example/db_helper/mongodb.dart';
import 'package:flutter_mongo_example/models/user_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class UserCreatePage extends StatefulWidget {
  final VoidCallback onSuccess;
  const UserCreatePage({Key? key, required this.onSuccess}) : super(key: key);

  @override
  State<UserCreatePage> createState() => _UserCreatePageState();
}

class _UserCreatePageState extends State<UserCreatePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CustomTextField(
            controller: nameController,
            hintText: "Name",
            validator: Validator().nameValidate,
          ),
          CustomTextField(
            controller: phoneController,
            hintText: "Phone",
            validator: Validator().phoneValidate,
          ),
          CustomButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  insertUser(nameController.text, phoneController.text)
                      .then((value) => widget.onSuccess());
                  FocusScope.of(context).unfocus();
                }
              },
              buttonTitle: "Insert")
        ]));
  }

  Future<void> insertUser(String name, String phone) async {
    var id = mongo.ObjectId();
    final data = UserModel(id: id, name: name, phone: phone);
    await MongoDatabase.insert(data);
  }
}
