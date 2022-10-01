import 'package:flutter/material.dart';
import 'package:flutter_mongo_example/validator/validator.dart';
import 'package:flutter_mongo_example/widgets/custom_button.dart';
import 'package:flutter_mongo_example/widgets/custom_text_field.dart';
import 'package:flutter_mongo_example/db_helper/mongodb.dart';
import 'package:flutter_mongo_example/models/user_model.dart';

class UserUpdatePage extends StatefulWidget {
  final VoidCallback onSuccess;
  final UserModel user;
  const UserUpdatePage({Key? key, required this.onSuccess, required this.user})
      : super(key: key);

  @override
  State<UserUpdatePage> createState() => _UserUpdatePageState();
}

class _UserUpdatePageState extends State<UserUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void initState() {
    name.text = widget.user.name;
    phone.text = widget.user.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: name,
            hintText: "",
            validator: Validator().nameValidate,
          ),
          CustomTextField(
            controller: phone,
            hintText: "",
            validator: Validator().phoneValidate,
          ),
          CustomButton(
            buttonTitle: "Update",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                updateUser(name.text, phone.text)
                    .then((value) => widget.onSuccess.call());
                FocusScope.of(context).unfocus();
              }
            },
          )
        ],
      ),
    );
  }

  Future<void> updateUser(String name, String phone) async {
    final user = UserModel(id: widget.user.id, name: name, phone: phone);
    await MongoDatabase.update(user);
  }
}
