import 'dart:convert';

import 'package:amazon_clone_tutorial/Constants/error_handling.dart';
import 'package:amazon_clone_tutorial/Constants/global_variables.dart';
import 'package:amazon_clone_tutorial/Constants/utils.dart';
import 'package:amazon_clone_tutorial/Providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../Models/product.dart';
import 'package:http/http.dart' as http;

class HomeServices{

  Future<List<Product>> fetchCategoryproducts({required BuildContext context,
  required String category
  })async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Product> productList =[];
    try{
      http.Response res = await http.get(Uri.parse('$uri/api/products?category=$category'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token' :userProvider.user.token,
      });
      httpErrorHandler(response: res, context: context, onSuccess: (){
        for(int i=0; i<jsonDecode(res.body).length; i++){
      productList.add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i],),),);

        }
      });
    }catch(e){
      showSnackBar(context, e.toString());
    }
    return productList;


  }

    Future<Product> fetchDealOfDay({required BuildContext context,
  })async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    Product product = Product(name: '', 
    description: '', 
    quantity: 0, 
    images: [], 
    category: '', 
    price: 0);
    try{
      http.Response res = await http.get(Uri.parse('$uri/api/deal-of-day'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token' :userProvider.user.token,
      });
      httpErrorHandler(response: res, context: context, onSuccess: (){
        product = Product.fromJson(res.body);
      });
    }catch(e){
      showSnackBar(context, e.toString());
    }
    return product;


  }
}