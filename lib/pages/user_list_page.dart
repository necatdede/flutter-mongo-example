import 'package:flutter/material.dart';
import 'package:flutter_mongo_example/cubit/user_list_cubit.dart';
import 'package:flutter_mongo_example/db_helper/mongodb.dart';
import 'package:flutter_mongo_example/pages/user_create_page.dart';
import 'package:flutter_mongo_example/pages/user_update_page.dart';
import 'package:flutter_mongo_example/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mongo_example/widgets/custom_alert_dialog.dart';
import 'package:flutter_mongo_example/widgets/custom_text_field.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final cubit = UserListCubit();
  @override
  void initState() {
    cubit.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Add",
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    content: UserCreatePage(
                      onSuccess: () {
                        cubit.getData();
                        Navigator.pop(context);
                      },
                    ),
                  ));
        },
      ),
      appBar: AppBar(
        title: const Text("Flutter Mongo"),
      ),
      body: Container(
        color: Colors.white,
        height: size.height,
        width: size.width,
        child: Center(
          child: BlocBuilder<UserListCubit, List<UserModel>>(
            bloc: cubit,
            builder: (context, state) {
              return Column(
                children: [
                  CustomTextField(
                    hintText: "Search",
                    onChanged: cubit.getDataByFilter,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        return getCard(state[index], context, cubit);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Card getCard(UserModel user, BuildContext context, UserListCubit cubit) {
  return Card(
    child: ListTile(
      title: Text(user.name),
      subtitle: Text(user.phone),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              tooltip: "Edit",
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          content: UserUpdatePage(
                            user: user,
                            onSuccess: () {
                              cubit.getData();
                              Navigator.pop(context);
                            },
                          ),
                        ));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              tooltip: "Delete",
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                      user: user,
                      onSuccess: () async {
                        await MongoDatabase.delete(user);
                        cubit.getData();
                      },
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
    ),
  );
}
