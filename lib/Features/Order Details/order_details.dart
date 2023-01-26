import 'package:amazon_clone_tutorial/Common/Widgets/custom_button.dart';
import 'package:amazon_clone_tutorial/Features/Admin/Services/admin_services.dart';
import 'package:amazon_clone_tutorial/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Constants/global_variables.dart';
import '../../Models/order.dart';
import '../Search/Screens/search_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName ='/order/details';
  final Order order;
 const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final AdminServices adminServices = AdminServices();
  int currentStep = 0;

  // Only for admin!!

  void changeOrderStatus(int status){
    adminServices.changeOrderStatus(context: context, status: status+1, order: widget.order, onSuccess: 
    (){
      setState(() {
      currentStep+=1;
    });
    });
  }

    void navigateToSearchScreen (String query){
      Navigator.pushNamed(context,SearchScreen.routeName,arguments: query );
    }

    @override
  void initState() {
    super.initState();
    currentStep =widget.order.status;
  }
  @override
  Widget build(BuildContext context) {
    final user =  Provider.of<UserProvider>(context).user;
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text("View order details",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,

                )              
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Date:    ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt) ) }'),
                  Text('Order ID:         ${widget.order.id}'),
                  Text('Order Total:    \$${widget.order.totalPrice}'),

                ],
              ),
            ),
            const SizedBox(height: 10,),
            const Text("Purchase Details",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),),

             Container(
          
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,

                )              
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for(int i = 0; i< widget.order.products.length;i++)
                   Row(
                      children: [
                      Image.network(widget.order.products[i].images[0],
                      height: 120,
                      width: 120,),
                      SizedBox(width: 5,),
                      Expanded(child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(widget.order.products[i].name,style: 
                        TextStyle(fontSize: 17,
                        fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        ),
                        Text('Qty: ${widget.order.quantity[i]}'),
                      ],))
                      
                    ],)
                   
                  
                 
                ],
              ),
            ),

                const SizedBox(height: 10,),
            const Text("Tracking",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),),

                         Container(
          
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,

                )              
              ),
              child: Stepper(
                currentStep: currentStep,
                controlsBuilder: (context, details) {
                  if(user.type=='admin'){
                    return CustomButton(text: 'Done', onTap: (){
                      changeOrderStatus(details.currentStep);
                    });
                  }
                  return const  SizedBox();
                },
                steps: [
                Step(title: const Text('Pending'),
                isActive: currentStep>0,
                state: currentStep >=0?StepState.complete:StepState.indexed,
                content: const Text('Your order is yet to be delivered')),
                Step(title: const Text('Completed'),
                isActive: currentStep>1,
                state: currentStep >1?StepState.complete:StepState.indexed,

                content: const Text('Your order has been delivered, you are yet to sign')),
                Step(title: const Text('Recieved'),
                isActive: currentStep>2,
                state: currentStep >2?StepState.complete:StepState.indexed,

                content: const Text('Your order has been delivered and signed by you')),
                Step(title: const Text('Delivered'),
                isActive: currentStep>=3,
                state: currentStep >=3?StepState.complete:StepState.indexed,

                content: const Text('Your order has been delivered and signed by you!')),
              ],)
         ) ]),
        ),
      ),
    );
  }
}