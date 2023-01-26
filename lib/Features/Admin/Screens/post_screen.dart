import 'package:amazon_clone_tutorial/Common/Widgets/loader.dart';
import 'package:amazon_clone_tutorial/Features/Admin/Screens/add_product_screen.dart';
import 'package:amazon_clone_tutorial/Features/Admin/Services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../Models/product.dart';
import '../../Account/Widgets/single_product.dart';

class PostsScreen extends StatefulWidget {
 const  PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  void navigateToAddProduct(){
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }
  final AdminServices adminServices = AdminServices();
  List<Product>? products;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts();
  }
  fetchAllProducts()async{
   products = await adminServices.fetchAllProducts(context);
   setState(() {
     
   });
  }
void deleteProduct(Product product,int index){
adminServices.deleteProduct(context: context, product: product, onSuccess: (){
  products!.removeAt(index);
  setState(() {
    
  });
});
}
  @override
  Widget build(BuildContext context) {
    return products ==null? const Loader():  Scaffold(
      body:   GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2),
          ),
            //scrollDirection: Axis.horizontal,
            itemCount: products!.length,
            itemBuilder: (context, index) {
              final productData = products![index];
              return Column(
                children: [
                  SizedBox(
                    height: 140,
                    child: SingleProduct(image: productData.images[0],)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Expanded(child: Text(productData.name,overflow: TextOverflow.ellipsis,maxLines: 2,)),
                        IconButton(onPressed: (){
                          deleteProduct(productData,index);
                        },icon:const Icon(Icons.delete_outline),)
                      ],
                    )
                ],
              );
            }),
      floatingActionButton: FloatingActionButton(
        onPressed:navigateToAddProduct ,
        tooltip: 'Add a product',
        child:   const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}