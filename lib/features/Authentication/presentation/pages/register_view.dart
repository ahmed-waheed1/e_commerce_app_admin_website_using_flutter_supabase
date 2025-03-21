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
import '../widgets/login_options.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = '/register-view';
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                  child: Form(
                    key: context.read<AuthenticationCubit>().formKey,
                    child: Column(
                      children: [
                        CustomTextFormFeild(
                          controller: context
                              .read<AuthenticationCubit>()
                              .nameController,
                          labelText: AppStrings.name,
                          keyboardType: TextInputType.name,
                          validator:
                              context.read<AuthenticationCubit>().validateName,
                        ),
                        const SizedBox(height: AppSizes.s20),
                        CustomTextFormFeild(
                          controller: context
                              .read<AuthenticationCubit>()
                              .emailController,
                          labelText: AppStrings.email,
                          keyboardType: TextInputType.emailAddress,
                          validator:
                              context.read<AuthenticationCubit>().validateEmail,
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
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !state,
                                validator: context
                                    .read<AuthenticationCubit>()
                                    .validatePassword,
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
                        BlocConsumer<AuthenticationCubit, AuthenticationState>(
                          listener: (context, state) {
                            if (state is SignUpSuccess) {
                              // Navigate to the home screen or show success message
                              Navigator.pushNamed(
                                  context, MainHomeView.routeName);
                            } else if (state is SignUpError) {
                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is SignUpLoading) {
                              return CircularProgressIndicator();
                            }
                            return LoginOptions(
                              text: AppStrings.register,
                              onPressed: () {
                                if (context
                                    .read<AuthenticationCubit>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  context
                                      .read<AuthenticationCubit>()
                                      .register();
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
                                    print('Login tapped');
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
