import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int maxLines;
  const CustomTextField({Key? key, required this.controller, required this.hintText,  this.maxLines=1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller ,
      decoration:  InputDecoration(
        hintText: hintText,
        border: 
       const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black38)
      ),
      enabledBorder:const  OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black38)
      ), ),
      validator: ((value) {
        if(value==null|| value.isEmpty){
          return 'Enter your $hintText';
        }
        return null;
      }),
    maxLines: maxLines,
    );
  }
}