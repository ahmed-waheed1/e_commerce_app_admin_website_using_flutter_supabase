import 'package:flutter/material.dart';

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
                      child: Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-vector/sale-banner-with-product-description_1361-1333.jpg?t=st=1742339904~exp=1742343504~hmac=f1b53a5c1c08f31a14b5820ddc37decb09afd42a4fc98afec5f05efde05a743f&w=1380')),
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
