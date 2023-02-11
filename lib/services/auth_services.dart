import 'dart:convert';

import 'package:authentication_using_nodejs/models/user.dart';
import 'package:authentication_using_nodejs/providers/user_provider.dart';
import 'package:authentication_using_nodejs/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: "",
        name: name,
        email: email,
        token: "",
        password: password,
      );

      http.Response res = await http.post(
        Uri.parse("${Constants.uri}/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      // now we have to handle error it can be of status code 200, 400, 500
      // this is how we handle in auth.js
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
              context,
              "Account created: Login with the same credentials",
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // SIGN IN USER
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse("${Constants.uri}/api/signin"),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // get instence of SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await prefs.setString("x-auth-token", jsonDecode(res.body)["token"]);
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
