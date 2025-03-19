import 'package:flutter/material.dart';
import '../../../../core/common_widgets/custom_cached_network_image.dart';
import '../../../../core/common_widgets/custom_elevated_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/style_manager.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.s20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
                        color: AppColors.kBlackColor, fontSize: AppSizes.s20),
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
                          color: AppColors.kWhiteColor, fontSize: AppSizes.s20),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
