import 'package:amazon_clone_tutorial/Common/Widgets/loader.dart';
import 'package:amazon_clone_tutorial/Features/Admin/Services/admin_services.dart';
import 'package:amazon_clone_tutorial/Features/Admin/Widget/category_products_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../Model/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>?earnings;
  @override
  void initState() {
    super.initState();
getEarnings();
  }
  void getEarnings() async{
    var earningData = await adminServices.getEarnings(context);
    totalSales =earningData['totalEarning'];
    earnings=earningData['sales'];
    setState(() {
      
    });


  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return earnings ==null || totalSales==null ? Loader(): Column(
      children: [
        Text('\$$totalSales',style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),),
        SizedBox(
          height: 250,
          child: CategoryProductChart(seriesList: [
            charts.Series(id: 'Sales', data: earnings!, domainFn: (Sales sales,_)=>sales.label, measureFn: (Sales sales,_)=> sales.earnings)
          ]),
        )
      ],

    );
  }
}