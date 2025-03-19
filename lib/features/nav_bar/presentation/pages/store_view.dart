import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_elevated_button.dart';
import '../../../../core/common_widgets/custom_text_form_feild.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/style_manager.dart';
import '../widgets/custom_product_card.dart';
import 'home_view.dart';

class StoreView extends StatelessWidget {
  static const String routeName = '/store_view';
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Center(
            child: Text(
              AppStrings.welcomeToOurMarketplace,
              style: getBoldStyle(
                  color: AppColors.kBlackColor, fontSize: AppSizes.s20),
            ),
          ),
          const SizedBox(height: AppSizes.s20),
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
