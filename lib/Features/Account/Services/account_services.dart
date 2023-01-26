import 'dart:convert';

import 'package:amazon_clone_tutorial/Features/Auth/Screens/auth_screen.dart';
import 'package:amazon_clone_tutorial/Models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Constants/error_handling.dart';
import '../../../Constants/global_variables.dart';
import '../../../Constants/utils.dart';
import '../../../Providers/user_provider.dart';

class AccountServices{
   Future<List<Order>> fetchMyOrders({required BuildContext context,
  })async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Order> orderList =[];
    try{
      http.Response res = await http.get(Uri.parse('$uri/api/orders/me'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token' :userProvider.user.token,
      });
      httpErrorHandler(response: res, context: context, onSuccess: (){
        for(int i=0; i<jsonDecode(res.body).length; i++){
      //orderList.add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i],),),);
      orderList.add(Order.fromMap(jsonDecode(res.body)[i]),);

        }
      });
    }catch(e){
      showSnackBar(context, e.toString());
    }
    return orderList;


  }

  void logOut(BuildContext context)async{
    try{
      SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
    Navigator.pushNamedAndRemoveUntil(context, AuthScreen.routeName, (route) => false);


    }catch(e){
      showSnackBar(context, e.toString());
    }
  }
}