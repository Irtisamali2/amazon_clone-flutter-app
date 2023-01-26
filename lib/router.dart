import 'package:amazon_clone_tutorial/Features/Address/Screens/address_screen.dart';
import 'package:amazon_clone_tutorial/Features/Admin/Screens/add_product_screen.dart';
import 'package:amazon_clone_tutorial/Features/Home/category_deals_screen.dart';
import 'package:amazon_clone_tutorial/Features/Home/home_screen.dart';
import 'package:amazon_clone_tutorial/Features/Order%20Details/order_details.dart';
import 'package:amazon_clone_tutorial/Features/Product_Details/Screens/product_details_screen.dart';
import 'package:amazon_clone_tutorial/Features/Search/Screens/search_screen.dart';
import 'package:amazon_clone_tutorial/Models/order.dart';
import 'package:flutter/material.dart';

import 'Common/Widgets/bottom_bar.dart';
import 'Features/Auth/Screens/auth_screen.dart';
import 'Models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {


  switch(routeSettings.name){
    case AuthScreen.routeName:
      return MaterialPageRoute(
        
        builder: (_) =>  AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen());
  case AddressScreen.routeName:
  var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) =>  AddressScreen(totalAmount: totalAmount,));
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (_) =>  BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AddProductScreen());
    case SearchScreen.routeName:
    var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) =>  SearchScreen(
          searchQuery: searchQuery
        ));
    case CategoryDealsScreen.routeName:
    var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) =>  CategoryDealsScreen(
          category: category,
        ));
    case ProductDetailScreen.routeName:
    var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        builder: (_) =>  ProductDetailScreen(
          product: product,
        ));
     case OrderDetailScreen.routeName:
    var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        builder: (_) =>  OrderDetailScreen(
          order: order ,
        ));
    default:
      return MaterialPageRoute(
        builder: (_) => const  Scaffold(
          body: Center(child: Text('Screen does not exist'),),
        ));

  }
}