import 'package:flutter/material.dart';
import '../../data/post_dao.dart';
import '../../screens/filter_screen.dart';

class CategoryButtonFront extends StatelessWidget {
  final String nameCategory;
  final Color colorCategory;
  final String searchCategory;

  const CategoryButtonFront(
      {super.key,
      required this.nameCategory,
      required this.colorCategory,
      required this.searchCategory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 1, 2, 6),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
             // padding: EdgeInsets.fromLTRB(0, 1, 0, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: colorCategory),
          onPressed: () {
            PostDao().findCategory(searchCategory);
            Navigator.of(context).push(MaterialPageRoute(builder: (contextNew) {
              return FilterScreen(
                  selectedCategory: searchCategory,
                  nameCategory: nameCategory,
                  colorCategory: colorCategory);
            }));
          },
          child: Text(
            nameCategory,
            style: const TextStyle(fontSize: 16),
          )),
    );
  }
}