
import 'package:amazon_clone_tutorial/Common/Widgets/bottom_bar.dart';
import 'package:amazon_clone_tutorial/Constants/global_variables.dart';
import 'package:amazon_clone_tutorial/Features/Admin/Screens/admin_screen.dart';
import 'package:amazon_clone_tutorial/Features/Auth/Services/auth_service.dart';
import 'package:amazon_clone_tutorial/Features/Home/home_screen.dart';
import 'package:amazon_clone_tutorial/Providers/user_provider.dart';
import 'package:amazon_clone_tutorial/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Features/Auth/Screens/auth_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>UserProvider())
  ],child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getUserData(context: context);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(primaryColor: Colors.blue,
      colorScheme: const ColorScheme.light(primary: GlobalVariables.secondaryColor),
      scaffoldBackgroundColor:GlobalVariables.backgroundColor,
      appBarTheme: const AppBarTheme(elevation: 0,
      iconTheme: IconThemeData(color: Colors.black)) ),
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty ? 
      Provider.of<UserProvider>(context).user.type=='user'?  BottomBar() :  AdminScreen() : AuthScreen(),
    );
  }
}

