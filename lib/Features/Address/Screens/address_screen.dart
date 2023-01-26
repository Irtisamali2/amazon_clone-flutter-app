// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone_tutorial/Constants/utils.dart';
import 'package:amazon_clone_tutorial/Features/Address/Services/address_Services.dart';
import 'package:amazon_clone_tutorial/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:amazon_clone_tutorial/Providers/user_provider.dart';

import '../../../Common/Widgets/custom_button.dart';
import '../../../Common/Widgets/custom_textFiled.dart';
import '../../../Constants/global_variables.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  final AddressServices addressServices = AddressServices();
   String addressToBeUsed="";
  List<PaymentItem> paymentItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total amount',
        status: PaymentItemStatus.final_price));

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onGooglePayResult(res) {
    if(Provider.of<UserProvider>(context,listen: false).user.address.isEmpty){
      addressServices.saveUserAddress(context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(context: context, address: addressToBeUsed, total: double.parse(widget.totalAmount));
  }
  void payPressed(String addressFromPRovider){
    addressToBeUsed ="";
    bool isForm = flatBuildingController.text.isNotEmpty || 
    areaController.text.isNotEmpty || 
    pincodeController.text.isNotEmpty || 
    cityController.text.isNotEmpty ;

    if(isForm && _addressFormKey.currentState!.validate() ){
      if(_addressFormKey.currentState!.validate()){
          addressToBeUsed='${flatBuildingController.text}, ${areaController.text}, ${cityController.text}, ${pincodeController.text}';
      }else{
        throw Exception('Please enter all the values');
      }
    }
    else if(addressFromPRovider.isNotEmpty){
        addressToBeUsed=addressFromPRovider;
      }else{
        showSnackBar(context, 'Error');
      }
  }
  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Or', style: TextStyle(fontSize: 18)),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
           Form(
                key: _addressFormKey,
                
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: "Flat, House no, Building",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: areaController,
                      hintText: "Area, Street",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: "Pincode",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: cityController,
                      hintText: "Town/City",
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    CustomButton(text: 'order', onTap: (){
       if(Provider.of<UserProvider>(context,listen: false).user.address.isEmpty){
      addressServices.saveUserAddress(context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(context: context, address: flatBuildingController.text + cityController.text, total: double.parse(widget.totalAmount));

                    })
                  ],
                ),
              ),
              
              GooglePayButton(
                onPressed:()=>  payPressed(address),
                width: double.infinity,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 50),
                paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}