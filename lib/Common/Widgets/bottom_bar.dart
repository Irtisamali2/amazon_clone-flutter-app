import 'package:amazon_clone_tutorial/Constants/global_variables.dart';
import 'package:amazon_clone_tutorial/Features/Account/Screens/account_screen.dart';
import 'package:amazon_clone_tutorial/Features/Cart/Screens/cart_screens.dart';
import 'package:amazon_clone_tutorial/Features/Home/home_screen.dart';
import 'package:amazon_clone_tutorial/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName ='/actual-home';
  BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
   int _page=0;
  double bottomBarWidth=42;
  double bottomBarBorderWith=5;
  List<Widget> pages=[
   const HomeScreen(),
   const AccountScreen(),
     CartScreen(),

  ];
  void updatePage(int page){
    setState(() {
      _page=page;
    });
  }
  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(currentIndex: _page,
      selectedItemColor: GlobalVariables.selectedNavBarColor,
      unselectedItemColor: GlobalVariables.unselectedNavBarColor,
      backgroundColor: GlobalVariables.backgroundColor,
      iconSize: 28,
      onTap: updatePage,
      items: [
        //Home
        BottomNavigationBarItem(icon: Container(width: bottomBarWidth,
        decoration: BoxDecoration(border: Border(top: BorderSide(
          color: _page==0 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
          width: bottomBarBorderWith 
        ))),
        child: const Icon(Icons.home_outlined),
        ),label: ''),
        //Account
        BottomNavigationBarItem(icon: Container(width: bottomBarWidth,
        decoration: BoxDecoration(border: Border(top: BorderSide(
          color: _page==1 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
          width: bottomBarBorderWith 
        ))),
        child: const Icon(Icons.person_outline_outlined),
        ),label: ''),
        //CART
        BottomNavigationBarItem(icon: Container(width: bottomBarWidth,
        decoration: BoxDecoration(border: Border(top: BorderSide(
          color: _page==2 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
          width: bottomBarBorderWith 
        ))),
        child: Badge(
          backgroundColor: Colors.white ,
          textColor: Colors.black,
          label: Text(userCartLen.toString()) ,
          // elevation: 0,
          // badgeContent:  Text(userCartLen.toString()),
          // badgeColor: Colors.white,
          child: const Icon(Icons.shopping_cart_outlined)),
        ),label: ''),
        
      ],),

    );
  }
}