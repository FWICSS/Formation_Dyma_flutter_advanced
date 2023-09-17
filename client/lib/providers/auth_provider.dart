import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:client/models/signin_form_model.dart';
import 'package:client/models/signup_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final String host =
      'http://' + (Platform.isAndroid ? "10.0.2.2" : "localhost");
  bool? isLoading = false;
  late Timer? timer;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? token;
  bool? isLoggedin;

  Future<void> initAuth() async {
    try {
      String? oldToken = await storage.read(key: 'token');
      if (oldToken == null) {
        isLoggedin = false;
      } else {
        token = oldToken;
        await refreshToken();
        if (token == null) {
          isLoggedin = false;
        } else {
          isLoggedin = true;
          initTimer();
        }
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshToken() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$host/api/auth/refresh-token'),
        headers: {'authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        token = json.decode(response.body);
        storage.write(key: 'token', value: token);
      } else {
        signout();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signup(SignUpForm signUpForm) async {
    try {
      isLoading = true;
      http.Response response = await http.post(
        Uri.parse('$host/api/user'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(signUpForm.toJson()),
      );
      isLoading = false;
      if (response.statusCode != 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

  Future<dynamic> signin(SignInForm signInForm) async {
    try {
      isLoading = true;
      http.Response response = await http.post(
        Uri.parse('$host/api/auth'),
        headers: {'Content-type': 'application/json'},
        body: json.encode(
          signInForm.toJson(),
        ),
      );
      print(jsonDecode(response.body));
      final Map<String, dynamic> body = json.decode(response.body);
      if (response.statusCode == 200) {
        final User user = User.fromJson(body['user']);
        token = body['token'];
        storage.write(key: 'token', value: token);
        isLoggedin = true;
        initTimer();
        return user;
      } else {
        return body;
      }
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

  void signout() {
    isLoggedin = false;
    token = null;
    storage.delete(key: 'token');
    if (timer != null) {
      timer?.cancel();
    }
  }

  void initTimer() {
    timer = Timer.periodic(Duration(minutes: 10), (timer) async {
      await refreshToken();
    });
  }
}
