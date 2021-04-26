import 'package:flutter/material.dart';
import 'package:meals/widgets/category_item.dart';

import '../data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GridView(
          padding: const EdgeInsets.all(20),
          children: DUMMY_CATEGORIES
              .map((catData) =>
                  CategoryItem(title: catData.title, color: catData.color, id: catData.id))
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
        );
  }
}
