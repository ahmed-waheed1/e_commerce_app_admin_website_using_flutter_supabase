import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/style_manager.dart';
import '../../domain/entities/category.dart';
import '../pages/category_products_view.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.s8),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(CategoryProductsView.routeName, arguments: category.name);
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: AppSizes.s40,
              backgroundColor: AppColors.kPrimaryColor,
              child: Icon(
                category.icon,
                size: AppSizes.s40,
                color: AppColors.kWhiteColor,
              ),
            ),
            const SizedBox(height: AppSizes.s10),
            Text(
              category.name,
              style: getRegularStyle(
                color: Colors.black,
                fontSize: AppSizes.s16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
