import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/style_manager.dart';
import '../widgets/custom_product_card.dart';
import 'home_view.dart';

class FavoriteView extends StatelessWidget {
  static const String routeName = '/favorite_view';
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Center(
            child: Text(
              AppStrings.yourFavoriteProducts,
              style: getBoldStyle(
                  color: AppColors.kBlackColor, fontSize: AppSizes.s20),
            ),
          ),
          const SizedBox(height: AppSizes.s20),
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
