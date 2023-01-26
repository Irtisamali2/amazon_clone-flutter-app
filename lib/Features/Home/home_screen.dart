import 'package:amazon_clone_tutorial/Features/Home/Widgets/address_box.dart';
import 'package:amazon_clone_tutorial/Features/Home/Widgets/carousel_image.dart';
import 'package:amazon_clone_tutorial/Features/Home/Widgets/deal_of%20_day.dart';
import 'package:amazon_clone_tutorial/Features/Home/Widgets/top_categories.dart';
import 'package:amazon_clone_tutorial/Features/Search/Screens/search_screen.dart';
import 'package:amazon_clone_tutorial/Providers/user_provider.dart';
import 'package:flutter/material.dart';

import '../../Constants/global_variables.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    void navigateToSearchScreen (String query){
      Navigator.pushNamed(context,SearchScreen.routeName,arguments: query );
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: ((value) {
                         if(value.isNotEmpty) {
                        navigateToSearchScreen(value);
                         }
                        }),
                        decoration: InputDecoration(
                          hintText: "Search Amazon.in ",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17
                          ),
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide.none),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(color: Colors.black38,width: 1)),
                                
                            
                            ),
                      ),
                    )),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic,color: Colors.black,size: 25,),
              )
            ],
          ),
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: GlobalVariables.appBarGradient)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:const [
            AddressBox(),
            SizedBox(height: 10,),
            TopCategories(),
            SizedBox(height: 10,),
            CarouselImage(),
            DealOfDay()
      
      
          ],
        ),
      ),
    );
  }
}
