import 'package:authentication_using_nodejs/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import '../utils/utils.dart';

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
}
