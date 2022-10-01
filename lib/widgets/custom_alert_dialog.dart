import 'package:flutter/material.dart';
import 'package:flutter_mongo_example/models/user_model.dart';

class CustomAlertDialog extends StatelessWidget {
  final UserModel user;

  final VoidCallback onSuccess;
  const CustomAlertDialog({
    Key? key,
    required this.user,
    required this.onSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${user.name} kişisi silinsin mi?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("İptal")),
        TextButton(
            onPressed: () {
              onSuccess.call();
              Navigator.pop(context);
            },
            child: const Text("Onayla")),
      ],
    );
  }
}
