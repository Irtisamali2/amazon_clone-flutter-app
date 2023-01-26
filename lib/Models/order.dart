// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazon_clone_tutorial/Models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final int orderedAt;
  final String userId;
  final int status;
  final double totalPrice;

  Order( {required this.totalPrice,required this.id, required this.products, required this.quantity, required this.address, required this.orderedAt, required this.userId, required this.status});


  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'orderedAt': orderedAt,
      'userId': userId,
      'status': status,
      'totalPrice':totalPrice
    };
  }

 factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'],
      products: List<Product>.from(map['products']?.map<Product>((x) => Product.fromMap(x['product']))),
      quantity: List<int>.from(map['products']?.map((x)=>x['quantity'],),),
      address: map['address'],
      orderedAt: map['orderedAt'],
      userId: map['userId'],
      status: map['status'],
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
    );
    
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
