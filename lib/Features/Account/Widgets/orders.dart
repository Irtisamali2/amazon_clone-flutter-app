import 'package:amazon_clone_tutorial/Common/Widgets/loader.dart';
import 'package:amazon_clone_tutorial/Constants/global_variables.dart';
import 'package:amazon_clone_tutorial/Features/Account/Services/account_services.dart';
import 'package:amazon_clone_tutorial/Features/Account/Widgets/single_product.dart';
import 'package:amazon_clone_tutorial/Features/Order%20Details/order_details.dart';
import 'package:flutter/material.dart';

import '../../../Models/order.dart';

class Orders extends StatefulWidget {
 const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
 List<Order>? orders;
 final AccountServices accountServices = AccountServices();

 @override
  void initState() {
    super.initState();
    fetchOrders();

  }
  void fetchOrders()async{
    orders =await accountServices.fetchMyOrders(context: context);
    setState(() {
      
    });

  }
  @override
  Widget build(BuildContext context) {
    return orders==null? const Loader(): 
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text('Your Order',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child:  Text('See All',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: GlobalVariables.selectedNavBarColor
              ),),
            ),
          ],
        ),
        //display Orders
        SingleChildScrollView(
          child: Container(height: MediaQuery.of(context).size.height/1.7,
          padding: const EdgeInsets.only(left: 10,right: 0,top: 20),
          child: GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2),
          ),
            //scrollDirection: Axis.horizontal,
            itemCount: orders?.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, OrderDetailScreen.routeName,arguments: orders![index]);
                },
                child: SingleProduct(image: orders![index].products[0].images[0]));
            },
          ),
          ),
        )
      ],
    );
  }
}