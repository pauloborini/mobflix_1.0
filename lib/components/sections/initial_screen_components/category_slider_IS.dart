import 'package:flutter/material.dart';
import 'package:mobflix/components/utilities/categories_map.dart';
import 'package:mobflix/components/utilities/category_button.dart';

import '../../utilities/colors_and_vars.dart';

class CategorySliderFront extends StatefulWidget {
  const CategorySliderFront({super.key});

  @override
  State<CategorySliderFront> createState() => _CategorySliderFrontState();
}

class _CategorySliderFrontState extends State<CategorySliderFront> {
  List<Widget> categoryList = [];

  void getCategories() {
    List<dynamic> responseData = categoryData;
    List<Widget> itemsList = [];
    responseData.forEach((category) {
      itemsList.add(CategoryButtonFront(
          nameCategory: category["categoria"],
          colorCategory: Color(category["colorInt"]),
          searchCategory: category["categoria"]));
    });
    setState(() {
      categoryList = itemsList;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        alignment: Alignment.center,
        color: stanColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: categoryList,
        ),
      ),
    );
  }
}
