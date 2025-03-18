import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/common_widgets/custom_cached_network_image.dart';
import '../../../../core/common_widgets/custom_elevated_button.dart';
import '../../../../core/common_widgets/custom_text_form_feild.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/images_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../domain/entities/category.dart';
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
          const SizedBox(height: AppSizes.s20),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.s20),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.s20),
                      child: CustomCachedNetworkImage(
                        imageUrl: AppStrings.imageUrl,
                      ),
                    ),
                    Positioned(
                      top: AppSizes.s10,
                      left: AppSizes.s10,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(AppSizes.s8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppSizes.s20),
                        ),
                        child: Text(AppStrings.specialOffer,
                            style: getMediumStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: AppSizes.s20)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.s20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.prductName,
                        style: getMediumStyle(
                            color: AppColors.kBlackColor,
                            fontSize: AppSizes.s20),
                      ),
                      IconButton(
                        color: AppColors.kGreyColor,
                        onPressed: () {
                          // todo implement see all functionality
                        },
                        icon: const Icon(Icons.favorite_rounded),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.s10),
                Padding(
                  padding: const EdgeInsets.all(AppSizes.s8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            AppStrings.newPrice,
                            style: getBoldStyle(
                                color: AppColors.kBlackColor,
                                fontSize: AppSizes.s20),
                          ),
                          const SizedBox(height: AppSizes.s10),
                          Text(
                            AppStrings.oldPrice,
                            style: getRegularStyle(
                                textDecoration: TextDecoration.lineThrough,
                                color: AppColors.kGreyColor,
                                fontSize: AppSizes.s16),
                          ),
                          const SizedBox(height: AppSizes.s10),
                        ],
                      ),
                      CustomElevatedButton(
                        borderSize: AppSizes.s8,
                        onPressed: () {
                          // todo implement add to cart functionality
                        },
                        widget: Text(
                          AppStrings.addToCart,
                          style: getMediumStyle(
                              color: AppColors.kWhiteColor,
                              fontSize: AppSizes.s20),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
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
