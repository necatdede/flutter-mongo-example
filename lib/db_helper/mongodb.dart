import 'dart:developer';

import 'package:flutter_mongo_example/db_helper/constants.dart';
import 'package:flutter_mongo_example/user_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final result = await userCollection.find().toList();
    return result;
  }

  static Future<String> insert(UserModel user) async {
    try {
      var result = userCollection.insertOne(user.toJson());
      if (result.isSuccess) {
        return "User Inserted";
      } else {
        return "Not Inserted";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
