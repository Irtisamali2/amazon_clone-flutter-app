import 'package:amazon_clone_tutorial/Constants/global_variables.dart';
import 'package:amazon_clone_tutorial/Features/Home/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);
void navigateToCategory(BuildContext context, String category){
  Navigator.pushNamed(context, CategoryDealsScreen.routeName,arguments:category );
}
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 75,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              navigateToCategory(context,GlobalVariables.categoryImages[index]['title']!);
            },
            child: Column(
              children: [Container(padding: 
              const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
              child: Image.asset(GlobalVariables.categoryImages[index]['image']!,
              fit: BoxFit.cover,
              height: 40,
              width: 40,),),),
              Text(GlobalVariables.categoryImages[index]['title']!,style: const TextStyle(fontSize: 12,
              fontWeight: FontWeight.w400),)],
            ),
          );
      },),
    );
  }
}