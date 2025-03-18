import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_text_form_feild.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/common_widgets/custom_elevated_button.dart';
import '../../../../core/utils/images_manager.dart';

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
        ],
      ),
    );
  }
}
