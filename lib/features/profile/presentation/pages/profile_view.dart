import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../Authentication/presentation/cubit/authentication_cubit.dart';
import '../../../Authentication/presentation/pages/login_view.dart';
import '../widgets/custom_profile_btn.dart';
import 'edit_name_view.dart';
import 'my_orders_view.dart';

class ProfileView extends StatefulWidget {
  static const String routeName = '/profile_view';
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Card(
            color: AppColors.kWhiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.s16),
            ),
            child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                if (state is GetUserDataLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetUserDataSuccess) {
                  final user = state.userDataModel;
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: AppSizes.s60,
                        backgroundColor: AppColors.kPrimaryColor,
                        foregroundColor: AppColors.kWhiteColor,
                        child: Icon(
                          Icons.person,
                          size: AppSizes.s50,
                          color: AppColors.kWhiteColor,
                        ),
                      ),
                      const SizedBox(height: AppSizes.s10),
                      Text(
                        user?.name ?? 'User Name',
                        style: getBoldStyle(
                          color: AppColors.kBlackColor,
                          fontSize: AppSizes.s20,
                        ),
                      ),
                      const SizedBox(height: AppSizes.s10),
                      Text(
                        user?.email ?? 'User Email',
                        style: getRegularStyle(
                          color: AppColors.kGreyColor,
                          fontSize: AppSizes.s16,
                        ),
                      ),
                      const SizedBox(height: AppSizes.s20),
                      CustomProfileBtn(
                        title: AppStrings.updateProfile,
                        icon: Icons.person,
                        onTap: () {
                          print('Update Profile Tapped');
                          navigateTo(context, const EditNameView());
                        },
                      ),
                      const SizedBox(height: AppSizes.s10),
                      CustomProfileBtn(
                        title: AppStrings.myOrders,
                        icon: Icons.settings,
                        onTap: () {
                          //todo navigate to settings screen
                          navigateTo(context, const MyOrdersView());
                        },
                      ),
                      const SizedBox(height: AppSizes.s10),
                      CustomProfileBtn(
                        title: AppStrings.logout,
                        icon: Icons.logout,
                        onTap: () {
                          print('Logout Tapped');
                          context.read<AuthenticationCubit>().signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginView.routeName, (route) => false);
                        },
                      ),
                    ],
                  );
                } else if (state is GetUserDataError) {
                  return Center(child: Text('Failed to load user data'));
                } else {
                  return Center(child: Text('No user data available'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
