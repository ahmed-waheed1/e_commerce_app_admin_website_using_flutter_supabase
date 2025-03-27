import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../../core/common_widgets/custom_cached_network_image.dart';
import '../../../../core/common_widgets/custom_elevated_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/style_manager.dart';
import '../../domain/entities/products_model/favorite.dart';
import '../../domain/entities/products_model/products_model.dart';
import '../cubit/product_detials_cubit.dart';
import '../pages/product_detials_view.dart';

class CustomProductCard extends StatelessWidget {
  final ProductsModel product;

  const CustomProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          ProductDetialsView.routeName,
          arguments: product,
        );
      },
      child: Padding(
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
                      imageUrl: product.imagePath ?? AppStrings.imageUrl,
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
                      child: Text('${product.sales} % off ',
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
                      product.productName!,
                      style: getMediumStyle(
                          color: AppColors.kBlackColor, fontSize: AppSizes.s20),
                    ),
                    BlocBuilder<ProductDetialsCubit, ProductDetialsState>(
                      builder: (context, state) {
                        final isFavorite = state is GetFavoritesSuccess &&
                            state.favorites.any((favorite) =>
                                favorite.forProduct == product.productId);

                        return IconButton(
                          color: isFavorite
                              ? AppColors.kPrimaryColor
                              : AppColors.kGreyColor,
                          onPressed: () {
                            final cubit = context.read<ProductDetialsCubit>();
                            if (isFavorite) {
                              final favorite = state.favorites.firstWhere(
                                  (favorite) =>
                                      favorite.forProduct == product.productId);
                              cubit.removeFavorite(favorite.id!);
                            } else {
                              cubit.addFavorite(Favorite(
                                forProduct: product.productId,
                                isFavorite: true,
                              ));
                            }
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                          ),
                        );
                      },
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
                          '\$${product.newPrice}',
                          style: getBoldStyle(
                              color: AppColors.kBlackColor,
                              fontSize: AppSizes.s20),
                        ),
                        const SizedBox(height: AppSizes.s10),
                        Text(
                          '\$${product.oldPrice}',
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
        ),
      ),
    );
  }
}
