import 'package:flutter/material.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/style_manager.dart';
import '../pages/home_view.dart';
import 'category_item.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Products',
          style: getBoldStyle(
            color: Colors.black,
            fontSize: AppSizes.s20,
          ),
        ),
        const SizedBox(height: AppSizes.s10),
        // todo implement popular products list
        SizedBox(
          height: AppSizes.s200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryItem(category: categories[index]);
            },
          ),
        ),
      ],
    );
  }
}
