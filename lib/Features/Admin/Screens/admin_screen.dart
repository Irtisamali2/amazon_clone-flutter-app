import 'package:amazon_clone_tutorial/Features/Admin/Screens/analytics_screen.dart';
import 'package:amazon_clone_tutorial/Features/Admin/Screens/order_screen.dart';
import 'package:amazon_clone_tutorial/Features/Admin/Screens/post_screen.dart';
import 'package:flutter/material.dart';

import '../../../Constants/global_variables.dart';

class AdminScreen extends StatefulWidget {
  AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
   int _page=0;
  double bottomBarWidth=42;
  double bottomBarBorderWith=5;
  List<Widget> pages=[
    const PostsScreen(),
    AnalyticsScreen(),

    OrderScreen()

  ];
  void updatePage(int page){
    setState(() {
      _page=page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
       appBar: PreferredSize(preferredSize: const Size.fromHeight(50),
      child: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(alignment: Alignment.topLeft,
            child: Image.asset('assets/images/amazon_in.png',width: 120,height: 45,color: Colors.black,),),
            const Text('Admin',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
          ],
        ),
        flexibleSpace: Container(decoration: 
       const BoxDecoration(gradient: GlobalVariables.appBarGradient)),
      ),),
     bottomNavigationBar: BottomNavigationBar(currentIndex: _page,
      selectedItemColor: GlobalVariables.selectedNavBarColor,
      unselectedItemColor: GlobalVariables.unselectedNavBarColor,
      backgroundColor: GlobalVariables.backgroundColor,
      iconSize: 28,
      onTap: updatePage,
      items: [
        //Posts
        BottomNavigationBarItem(icon: Container(width: bottomBarWidth,
        decoration: BoxDecoration(border: Border(top: BorderSide(
          color: _page==0 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
          width: bottomBarBorderWith 
        ))),
        child: const Icon(Icons.home_outlined),
        ),label: ''),
        //Analytics
        BottomNavigationBarItem(icon: Container(width: bottomBarWidth,
        decoration: BoxDecoration(border: Border(top: BorderSide(
          color: _page==1 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
          width: bottomBarBorderWith 
        ))),
        child: const Icon(Icons.analytics_outlined),
        ),label: ''),
        //Orders
        BottomNavigationBarItem(icon: Container(width: bottomBarWidth,
        decoration: BoxDecoration(border: Border(top: BorderSide(
          color: _page==2 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
          width: bottomBarBorderWith 
        ))),
        child: const Icon(Icons.all_inbox_outlined),
        ),label: ''),
        
      ],),

    );
  }
}