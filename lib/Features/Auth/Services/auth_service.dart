import 'dart:convert';

import 'package:amazon_clone_tutorial/Constants/error_handling.dart';
import 'package:amazon_clone_tutorial/Constants/utils.dart';
import 'package:amazon_clone_tutorial/Features/Home/home_screen.dart';
import 'package:amazon_clone_tutorial/Models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Common/Widgets/bottom_bar.dart';
import '../../../Constants/global_variables.dart';
import '../../../Models/user.dart';
import 'package:http/http.dart' as http;

import '../../../Providers/user_provider.dart';

class AuthService {
  //Sign Up User

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '',
          cart: [],
          );

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          });
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, "Account Created! Login with same credentials.");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          });
      print(res.body);
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // ignore: use_build_context_synchronously
            Provider.of<UserProvider>(context, listen: false).setUSer(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            // ignore: use_build_context_synchronously
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': token!
          });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=utf-8',
              'x-auth-token': token
            });
        // ignore: use_build_context_synchronously
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUSer(userRes.body);
      }
      // http.Response res = await http.post(Uri.parse('$uri/api/signin'),
      //     body: jsonEncode({
      //       'email': email,
      //       'password': password,
      //     }),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=utf-8'
      //     });
      // httpErrorHandler(response: res,
      // context: context,
      // onSuccess: () async{
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   Provider.of<UserProvider>(context,listen: false).setUSer(res.body);
      //   await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
      //   Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route)=>false);

      // });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get all the products
}
