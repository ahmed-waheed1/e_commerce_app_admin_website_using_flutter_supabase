import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_elevated_button.dart';
import '../../../../core/common_widgets/custom_text_form_feild.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/images_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../domain/entities/category.dart';
import '../widgets/custom_product_card.dart';
import '../widgets/popular_products.dart';

class HomeView extends StatelessWidget {
  static const String routeName = '/home_view';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          CustomTextFormFeild(
            labelText: 'Search',
            keyboardType: TextInputType.text,
            suffixIcon: CustomElevatedButton(
              borderSize: AppSizes.s8,
              onPressed: () {
                // todo implement search functionality
              },
              widget: const Icon(Icons.search),
            ),
            prefixIcon: Icons.search,
            onTap: () {
              // todo implement search functionality
            },
          ),
          const SizedBox(height: AppSizes.s20),
          Image.asset(
            ImagesManager.buy,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: AppSizes.s20),
          const PopularProducts(),
          Padding(
            padding: const EdgeInsets.all(AppSizes.s8),
            child: Text(
              AppStrings.newArrivals,
              style: getBoldStyle(
                  color: AppColors.kBlackColor, fontSize: AppSizes.s20),
            ),
          ),
          const SizedBox(height: AppSizes.s10),
          ListView.builder(
            itemCount: categories.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CustomProductCard();
            },
          ),
        ],
      ),
    );
  }
}

// todo implement categories list
// todo to be refactored to use a bloc
List<Category> categories = [
  Category(name: 'Electronics', icon: Icons.electrical_services),
  Category(name: 'Fashion', icon: Icons.checkroom),
  Category(name: 'Home', icon: Icons.home),
  Category(name: 'Beauty', icon: Icons.brush),
  Category(name: 'Sports', icon: Icons.sports),
];
