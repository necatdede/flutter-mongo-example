import 'package:flutter/material.dart';
import 'package:flutter_mongo_example/db_helper/mongodb.dart';
import 'package:flutter_mongo_example/user_model.dart';
import 'package:flutter_mongo_example/user_update_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<UserModel> users = [];

  @override
  void initState() {
    get(users);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        height: size.height,
        width: size.width,
        child: Center(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return getCard(users[index], context);
            },
          ),
        ),
      ),
    );
  }
}

void get(List<UserModel> users) async {
  final result = await MongoDatabase.getData();
  for (int i = 0; i < result.length; i++) {
    final UserModel user = UserModel.fromJson(result[i]);
    users.add(user);
  }
}

Card getCard(UserModel user, BuildContext context) {
  return Card(
    child: ListTile(
      title: Text(user.name),
      subtitle: Text(user.password),
      trailing: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) {
                    return const UserUpdatePage();
                  },
                  settings: RouteSettings(arguments: user)),
            );
          },
          icon: const Icon(Icons.edit)),
    ),
  );
}
