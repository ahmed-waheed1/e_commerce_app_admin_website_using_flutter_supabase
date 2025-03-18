import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_text_form_feild.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/style_manager.dart';
import '../cubit/visiability_cubit.dart';
import '../widgets/login_options.dart';

class RegisterView extends StatelessWidget {
  static const String routeName = '/login-view';
  const RegisterView({super.key});

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
              Text(
                AppStrings.welcomeToOurMarketplace,
                style: getMediumStyle(
                  color: AppColors.kBlackColor,
                  fontSize: AppSizes.s24,
                ),
              ),
              const SizedBox(height: AppSizes.s20),
              Card(
                color: AppColors.kWhiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.s16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.s16),
                  child: Column(
                    children: [
                      CustomTextFormFeild(
                        labelText: AppStrings.name,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: AppSizes.s20),
                      CustomTextFormFeild(
                        labelText: AppStrings.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: AppSizes.s20),
                      BlocProvider(
                        create: (context) => VisiabilityCubit(),
                        child: BlocBuilder<VisiabilityCubit, bool>(
                          builder: (context, state) {
                            return CustomTextFormFeild(
                              labelText: AppStrings.password,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !state,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.kBlackColor,
                                ),
                                onPressed: () {
                                  context
                                      .read<VisiabilityCubit>()
                                      .toggleVisibility();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppSizes.s20),
                      LoginOptions(
                        text: AppStrings.register,
                        onPressed: () {},
                      ),
                      const SizedBox(height: AppSizes.s20),
                      Text(
                        AppStrings.or,
                        style: getRegularStyle(
                          color: AppColors.kBlackColor,
                          fontSize: AppSizes.s16,
                        ),
                      ),
                      const SizedBox(height: AppSizes.s20),
                      LoginOptions(
                        text: AppStrings.continueWithGoogle,
                        onPressed: () {},
                      ),
                      const SizedBox(height: AppSizes.s20),
                      RichText(
                        text: TextSpan(
                          text: AppStrings.alreadyHaveAnAccount,
                          style: getRegularStyle(
                            color: AppColors.kBlackColor,
                            fontSize: AppSizes.s16,
                          ),
                          children: [
                            TextSpan(
                              text: AppStrings.login,
                              style: getRegularStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: AppSizes.s16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  log('Sign Up tapped');
                                  navigateBack(context);
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSizes.s20),
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
