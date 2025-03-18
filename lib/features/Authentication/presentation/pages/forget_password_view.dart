import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_text_form_feild.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/common_widgets/custom_elevated_button.dart';

class ForgetPasswordView extends StatelessWidget {
  static const String routeName = '/forget-password-view';
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSizes.s150),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppStrings.forgetPassword,
                  style: getBoldStyle(
                    color: AppColors.kBlackColor,
                    fontSize: AppSizes.s24,
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.s16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.s16),
                  child: Column(
                    children: [
                      CustomTextFormFeild(
                        labelText: AppStrings.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: AppSizes.s20),
                      CustomElevatedButton(
                        onPressed: () {},
                        widget: Text(AppStrings.resetPassword),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
