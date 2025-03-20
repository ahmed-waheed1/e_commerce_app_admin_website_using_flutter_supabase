import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_elevated_button.dart';
import '../../../../core/common_widgets/custom_text_form_feild.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/style_manager.dart';
import '../cubit/authentication_cubit.dart';

class ForgetPasswordView extends StatelessWidget {
  static const String routeName = '/forget-password-view';
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

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
                        controller: emailController,
                        labelText: AppStrings.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: AppSizes.s20),
                      BlocConsumer<AuthenticationCubit, AuthenticationState>(
                        listener: (context, state) {
                          if (state is PasswordResetSuccess) {
                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text(AppStrings.passwordResetSuccess)),
                            );
                          } else if (state is PasswordResetError) {
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is PasswordResetLoading) {
                            return CircularProgressIndicator();
                          }
                          return CustomElevatedButton(
                            onPressed: () {
                              final email = emailController.text;
                              context
                                  .read<AuthenticationCubit>()
                                  .resetPassword(email: email);
                            },
                            widget: Text(AppStrings.resetPassword),
                          );
                        },
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
