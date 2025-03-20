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
import '../../../nav_bar/presentation/pages/main_home_view.dart';
import '../cubit/authentication_cubit.dart';
import '../cubit/visiability_cubit.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/login_options.dart';
import 'forget_password_view.dart';
import 'register_view.dart';

class LoginView extends StatefulWidget {
  static const String routeName = '/login-view';
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: context.read<AuthenticationCubit>().formKey,
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
                          controller: context
                              .read<AuthenticationCubit>()
                              .emailController,
                          labelText: AppStrings.email,
                        ),
                        const SizedBox(height: AppSizes.s20),
                        BlocProvider(
                          create: (context) => VisiabilityCubit(),
                          child: BlocBuilder<VisiabilityCubit, bool>(
                            builder: (context, state) {
                              return CustomTextFormFeild(
                                controller: context
                                    .read<AuthenticationCubit>()
                                    .passwordController,
                                labelText: AppStrings.password,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomTextButton(
                              text: AppStrings.forgotPassword,
                              onPressed: () {
                                log('Forgot Password tapped');
                                Navigator.pushNamed(
                                    context, ForgetPasswordView.routeName);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.s20),
                        BlocConsumer<AuthenticationCubit, AuthenticationState>(
                          listener: (context, state) {
                            if (state is LoginSuccess) {
                              // Navigate to the home screen or show success message
                              Navigator.pushNamed(
                                  context, MainHomeView.routeName);
                            } else if (state is LoginError) {
                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return CircularProgressIndicator();
                            }
                            return LoginOptions(
                              text: AppStrings.login,
                              onPressed: () {
                                if (context
                                    .read<AuthenticationCubit>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  context.read<AuthenticationCubit>().login();
                                }
                              },
                            );
                          },
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
                          onPressed: () {
                            context.read<AuthenticationCubit>().googleSignIn();
                          },
                        ),
                        const SizedBox(height: AppSizes.s20),
                        RichText(
                          text: TextSpan(
                            text: AppStrings.dosenotHaveAccount,
                            style: getRegularStyle(
                              color: AppColors.kBlackColor,
                              fontSize: AppSizes.s16,
                            ),
                            children: [
                              TextSpan(
                                text: AppStrings.signUp,
                                style: getRegularStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontSize: AppSizes.s16,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    log('Sign Up tapped');
                                    navigateTo(
                                      context,
                                      const RegisterView(),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
