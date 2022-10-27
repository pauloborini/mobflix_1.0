import 'package:flutter/material.dart';
import 'package:mobflix/data/post_dao.dart';
import 'package:mobflix/screens/find_screen.dart';

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
    return SizedBox(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: colorCategory),
          onPressed: () {
            PostDao().find(searchCategory);
            Navigator.of(context).push(MaterialPageRoute(builder: (contextNew) {
              return FindScreen(
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
