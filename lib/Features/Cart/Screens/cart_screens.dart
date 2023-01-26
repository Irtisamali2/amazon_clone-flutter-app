import 'package:amazon_clone_tutorial/Common/Widgets/custom_button.dart';
import 'package:amazon_clone_tutorial/Features/Address/Screens/address_screen.dart';
import 'package:amazon_clone_tutorial/Features/Cart/Widget/cart_subtotal.dart';
import 'package:amazon_clone_tutorial/Features/Cart/Widget/cart_product.dart';
import 'package:amazon_clone_tutorial/Features/Home/Widgets/address_box.dart';
import 'package:amazon_clone_tutorial/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constants/global_variables.dart';
import '../../Search/Screens/search_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
     void navigateToSearchScreen (String query){
      Navigator.pushNamed(context,SearchScreen.routeName,arguments: query );
    }
     void navigateToAddress (int sum){
      Navigator.pushNamed(context,AddressScreen.routeName,arguments: sum.toString() );
    }
  @override
  Widget build(BuildContext context) {

      final user = context.watch<UserProvider>().user;
      int sum=0;
      for (var element in user.cart) {sum= element['quantity']*element['product']['price'] as int;}
  print(sum.toString());
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
      body: SingleChildScrollView(child: 
      Column(
        children: [
          const AddressBox(),
          const CartSubTotal(),
          CustomButton(text: 'Proceed to Buy (${user.cart.length} cart', 
          color: Colors.yellow[600],
          onTap:(() =>  navigateToAddress(sum))),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(height: 5,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: user.cart.length,
            itemBuilder: (BuildContext context, int index) { 
            return CartProduct(index: index);
           },)
          
        ],
      )),
    );
  }
}