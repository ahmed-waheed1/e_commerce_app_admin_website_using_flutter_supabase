import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_cached_network_image.dart';
import '../../../../core/common_widgets/custom_text_form_feild.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/style_manager.dart';
import '../../data/repositories/home_repository_implementation.dart';

import '../../domain/entities/products_model/comment.dart';
import '../../domain/entities/products_model/products_model.dart';
import '../../domain/entities/products_model/rate.dart';
import '../cubit/product_detials_cubit.dart';

class ProductDetialsView extends StatelessWidget {
  static const String routeName = '/product_details_view';
  const ProductDetialsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsModel product = Get.arguments as ProductsModel;

    return BlocProvider(
      create: (context) => ProductDetialsCubit(
        locator<HomeRepositoryImplementation>(),
      )..getProductDetails(product.productId!),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.kPrimaryColor,
          title: Text(product.productName ?? 'No Product Name',
              style: getBoldStyle(
                color: AppColors.kWhiteColor,
                fontSize: AppSizes.s20,
              )),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.kWhiteColor),
            onPressed: () {
              navigateBack(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.s20),
            child: BlocBuilder<ProductDetialsCubit, ProductDetialsState>(
              builder: (context, state) {
                if (state is ProductRatingLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductRatingSuccess) {
                  final productRating = state.productRating;
                  final averageRating = state.averageRating;
                  final comments = state.comments;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.s20),
                        child: CustomCachedNetworkImage(
                          imageUrl: product.imagePath ?? AppStrings.imageUrl,
                        ),
                      ),
                      const SizedBox(height: AppSizes.s20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.productName ?? 'No Product Name',
                            style: getBoldStyle(
                              color: AppColors.kBlackColor,
                              fontSize: AppSizes.s24,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${product.newPrice}',
                                style: getBoldStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontSize: AppSizes.s20,
                                ),
                              ),
                              const SizedBox(height: AppSizes.s10),
                              Text(
                                '\$${product.oldPrice}',
                                style: getRegularStyle(
                                  textDecoration: TextDecoration.lineThrough,
                                  color: AppColors.kGreyColor,
                                  fontSize: AppSizes.s16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.s20),
                      Text(
                        product.description ?? 'No Description Available',
                        style: getRegularStyle(
                          color: AppColors.kBlackColor,
                          fontSize: AppSizes.s16,
                        ),
                      ),
                      const SizedBox(height: AppSizes.s20),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.kAmberColor,
                            size: AppSizes.s24,
                          ),
                          const SizedBox(width: AppSizes.s10),
                          Text(
                            averageRating.toStringAsFixed(1),
                            style: getBoldStyle(
                              color: AppColors.kBlackColor,
                              fontSize: AppSizes.s20,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: const Icon(Icons.favorite_border),
                            color: AppColors.kPrimaryColor,
                            onPressed: () {
                              // todo: Implement favorite functionality
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBar.builder(
                              initialRating: productRating.isNotEmpty
                                  ? productRating[0].rate!.toDouble()
                                  : 0.0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                              onRatingUpdate: (rating) {
                                // todo: Implement rating functionality
                                context
                                    .read<ProductDetialsCubit>()
                                    .addOrUpdateRating(
                                      product.productId!,
                                      Rate(
                                        rate: rating.toInt(),
                                      ),
                                    );
                                print(rating);
                              }),
                        ],
                      ),
                      const SizedBox(height: AppSizes.s20),
                      CustomTextFormFeild(
                        controller: context
                            .read<ProductDetialsCubit>()
                            .commentController,
                        labelText: 'Add a comment',
                        keyboardType: TextInputType.text,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            final commentText = context
                                .read<ProductDetialsCubit>()
                                .commentController
                                .text;
                            if (commentText.isNotEmpty) {
                              context.read<ProductDetialsCubit>().addComment(
                                    product.productId!,
                                    Comment(
                                      comment: commentText,
                                    ),
                                  );
                              context
                                  .read<ProductDetialsCubit>()
                                  .commentController
                                  .clear();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: AppSizes.s20),
                      Text(
                        'Comments',
                        style: getBoldStyle(
                          color: AppColors.kBlackColor,
                          fontSize: AppSizes.s20,
                        ),
                      ),
                      const SizedBox(height: AppSizes.s10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return ListTile(
                            title: Text(comment.username ?? ''),
                            subtitle: Text(comment.comment ?? ''),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return Center(child: Text('Failed to load product details'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
