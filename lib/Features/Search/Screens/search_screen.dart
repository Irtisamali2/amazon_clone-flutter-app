// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone_tutorial/Common/Widgets/loader.dart';
import 'package:amazon_clone_tutorial/Features/Home/Widgets/address_box.dart';
import 'package:amazon_clone_tutorial/Features/Product_Details/Screens/product_details_screen.dart';
import 'package:amazon_clone_tutorial/Features/Search/Services/search_services.dart';
import 'package:amazon_clone_tutorial/Features/Search/Widgets/searched_product.dart';
import 'package:flutter/material.dart';

import '../../../Constants/global_variables.dart';
import '../../../Models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName ='/search-screen';
  final String searchQuery;
  SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? product;
  final SearchServices searchServices = SearchServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchedProduct();
  }
   void navigateToSearchScreen (String query){
      Navigator.pushNamed(context,SearchScreen.routeName,arguments: query );
    }
  fetchSearchedProduct() async{
    product = await searchServices.fetchSearchedProduct(context: context, searchQuery: widget.searchQuery);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return product== null ? const Loader() : Scaffold(
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
                        onFieldSubmitted: navigateToSearchScreen,
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
      body: Column(
        children: [
          const AddressBox(),
          const SizedBox(height: 10,),
          Expanded(child: ListView.builder(
            itemCount: product!.length,
            itemBuilder: (context, index) { 
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductDetailScreen.routeName,
                    arguments: product![index]);

                  },
                  child: SearchedProduct(product: product![index],));
            },
          ),)
        ],
      ),
    );
  }
}