import 'package:amazon_clone_tutorial/Common/Widgets/loader.dart';
import 'package:amazon_clone_tutorial/Features/Account/Widgets/single_product.dart';
import 'package:amazon_clone_tutorial/Features/Admin/Screens/admin_screen.dart';
import 'package:amazon_clone_tutorial/Features/Admin/Services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../Models/order.dart';
import '../../Order Details/order_details.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order>? orders;
  AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async{

   orders= await adminServices.fetchAllOrders(context);
   setState(() {
     
   });
  }
  @override
  Widget build(BuildContext context) {
    return orders==null ? const Loader(): GridView.builder(
      gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: orders!.length,
      itemBuilder: ((context, index) {
        final orderData = orders![index];
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, 
          OrderDetailScreen.routeName,arguments: orderData);
          },
          child: SizedBox(height: 140,
          child: SingleProduct(image: orderData.products[0].images[0]),),
        );
      }),
    );
  }
}