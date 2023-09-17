import 'dart:convert';
import 'dart:io';

import 'package:client/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  final String host =
      'http://' + (Platform.isAndroid ? "10.0.2.2" : "localhost");
  User? user;
  late AuthProvider authProvider;

  void updateUser(User updateUser) {
    user = updateUser;
    notifyListeners();
  }

  void update(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
    if (user == null && authProvider.isLoggedin!) {
      fetchCurrentUser();
    }
  }

  Future<void> fetchCurrentUser() async {
    try {
      http.Response response = await http.get(
          Uri.parse('$host/api/user/current'),
          headers: {'authorization': 'Bearer ${authProvider.token}'});

      if (response.statusCode == 200) {
        updateUser(
          User.fromJson(
            json.decode(response.body),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
