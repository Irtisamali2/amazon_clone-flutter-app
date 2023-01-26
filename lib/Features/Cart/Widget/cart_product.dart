// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone_tutorial/Features/Cart/Services/cart_services.dart';
import 'package:amazon_clone_tutorial/Features/Product_Details/Services/product_details_services.dart';
import 'package:amazon_clone_tutorial/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/product.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices= ProductDetailsServices();
  void increasequantity(Product product){
    productDetailsServices.addToCart(context: context, product: product);
  }

  final CartServices cartServices =  CartServices();
  void decreasequantity(Product product){
    cartServices.removeFromCart(context: context, product: product);
  }
  @override
  Widget build(BuildContext context) {
    final productCart= context.watch<UserProvider>().user.cart[widget.index];
    final product= Product.fromMap(productCart['product']);
    final quantity= productCart['quantity'];
    double screesize = MediaQuery.of(context).size.height;

    
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(product.images[0],fit: BoxFit.contain,height: 135,
              width: 135,),
              Expanded(
                child:  Container(
                  alignment: Alignment.topLeft,
                  height: 135,
                  padding: const EdgeInsets.symmetric(horizontal:10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name,style: const TextStyle(fontSize: 15),maxLines: 2,),
                       
                      Text('\$${product.price}',maxLines: 2,style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                     const  Text('Egligible for FREE Shipping'),
                            
                     const  Text('In Stock',maxLines: 2,style:  TextStyle(
                        color: Colors.teal
                      ))
                            
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color:Colors.black12,
                    width: 1.5
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                  
                 ),
                 child: Row(
                  children: [
                    InkWell(
                      onTap: () => decreasequantity(product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(Icons.remove,size: 18,),
                    
                      ),
                    ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(0)
                        ),
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: Text(quantity.toString()),

                    ),
                    InkWell(
                      onTap: () => increasequantity(product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(Icons.add,size: 18,),
                    
                      ),
                    ),
                  ],
                 ),
              )

          ]),
        )
      ],
    );
  ;
  }
}