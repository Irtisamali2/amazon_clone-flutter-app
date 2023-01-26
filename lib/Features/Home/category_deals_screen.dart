import 'package:amazon_clone_tutorial/Common/Widgets/loader.dart';
import 'package:amazon_clone_tutorial/Features/Home/Services/home_services.dart';
import 'package:amazon_clone_tutorial/Features/Product_Details/Screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../Constants/global_variables.dart';
import '../../Models/product.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/catefory-deals';
  final String category;
  CategoryDealsScreen({Key? key, required this.category}) : super(key: key);
  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {

  List<Product>? productList;
  HomeServices homeServices = HomeServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryProdcuts();
  }
  fetchCategoryProdcuts() async{
    productList =await homeServices.fetchCategoryproducts(context: context, category: widget.category);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return productList==null ? const Loader() : Scaffold(
       appBar: PreferredSize(preferredSize: const Size.fromHeight(50),
      child: AppBar(
        title: Text(widget.category,style: const TextStyle(color: Colors.black),), 
        flexibleSpace: Container(decoration: 
       const BoxDecoration(gradient: GlobalVariables.appBarGradient)),
       
      ),),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
                  ),
                  child: Text('Keep shopping for ${widget.category}',
                  style:const TextStyle(fontSize: 20),),
          ),
          productList!.isEmpty ? Expanded(
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children:const  [
                   Center(child: Text('No Product in this Category')),
                ],
              ),
          ) : 
          SizedBox(
            height: 170,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:1,
              childAspectRatio: 1.4,mainAxisSpacing: 10), 
              itemCount: productList!.length,
              itemBuilder: ( context,  index) { 
                final product = productList![index];
                  return GestureDetector(
                    onTap: (() {
                      
                      Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
                    }),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 130,
                          child: DecoratedBox(decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12,width: 0.5,
                            )
                          ),
                          child:  Padding( padding: const EdgeInsets.all(10),
                          child: Image.network(product.images[0]),),)
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.only(left: 0,
                          top: 5,
                          right:15),
                          child:Text(product.name,maxLines: 1,overflow: TextOverflow.ellipsis,)
                  
                        )
                      ],
                    ),
                  );
               },),
          )
        ],
      ),
    
    );
  }
}