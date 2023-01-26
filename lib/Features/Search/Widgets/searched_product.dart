import 'package:amazon_clone_tutorial/Features/Search/Widgets/stars.dart';
import 'package:amazon_clone_tutorial/Models/product.dart';
import 'package:flutter/material.dart';


class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double myRating=0;
    double avrRating=0;
    double totalRating=0;
 if(product.rating!.isNotEmpty){
   for(int i =0;i<product.rating!.length; i++){
      totalRating+=product.rating![i].rating;
    }
 }
    if(totalRating!=0){
      avrRating=totalRating/product.rating!.length;

    }
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
                       Stars(rating: avrRating),
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
      ],
    );
  }
}