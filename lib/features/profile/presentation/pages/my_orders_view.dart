import 'package:flutter/material.dart';

import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

class MyOrdersView extends StatelessWidget {
  static const String routeName = '/my_orders_view';
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        title: const Text(AppStrings.myOrders),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.kWhiteColor),
          onPressed: () {
            navigateBack(context);
          },
        ),
      ),
      body: const Center(
        child: Text('No orders yet!'),
      ),
    );
  }
}
