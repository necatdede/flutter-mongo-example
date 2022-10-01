import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mongo_example/db_helper/mongodb.dart';
import 'package:flutter_mongo_example/models/user_model.dart';

class UserListCubit extends Cubit<List<UserModel>> {
  UserListCubit() : super(<UserModel>[]);

  Future<void> getData() async {
    List<UserModel> users = [];
    var result = await MongoDatabase.getData();
    for (int i = 0; i < result.length; i++) {
      final UserModel user = UserModel.fromJson(result[i]);
      users.add(user);
    }
    emit(users);
  }

  Future<void> getDataByFilter(String searchText) async {
    List<UserModel> users = [];
    var result = await MongoDatabase.getDataByFilter(searchText);
    for (int i = 0; i < result.length; i++) {
      final UserModel user = UserModel.fromJson(result[i]);
      users.add(user);
    }
    emit(users);
  }
}
