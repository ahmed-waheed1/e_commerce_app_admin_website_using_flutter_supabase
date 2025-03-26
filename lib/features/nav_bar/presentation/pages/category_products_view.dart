import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/functions/navigator.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/style_manager.dart';
import '../../data/repositories/home_repository_implementation.dart';
import '../cubit/product_detials_cubit.dart';
import '../widgets/custom_product_card.dart';

class CategoryProductsView extends StatelessWidget {
  static const String routeName = '/category_products_view';
  const CategoryProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final String categoryName = Get.arguments as String;

    return BlocProvider(
      create: (context) => ProductDetialsCubit(
        locator<HomeRepositoryImplementation>(),
      )..getProductsByCategory(categoryName),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.kPrimaryColor,
          title: Text(categoryName,
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
        body: BlocBuilder<ProductDetialsCubit, ProductDetialsState>(
          builder: (context, state) {
            if (state is CategoryProductsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CategoryProductsSuccess) {
              final products = state.products;
              if (products.isEmpty) {
                return Center(
                  child: Text(
                    'No products found in this category',
                    style: getRegularStyle(
                      color: AppColors.kBlackColor,
                      fontSize: AppSizes.s16,
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return CustomProductCard(
                      product: product,
                    );
                  },
                ),
              );
            } else if (state is CategoryProductsError) {
              return Center(child: Text(state.error));
            } else {
              return Center(child: Text('Failed to load products'));
            }
          },
        ),
      ),
    );
  }
}
