import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../cubit/nav_bar_cubit.dart';
import '../cubit/nav_bar_state.dart';

class MainHomeView extends StatelessWidget {
  static const String routeName = '/main_home_view';

  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<NavBarCubit, NavBarState>(
          builder: (context, state) {
            return context.read<NavBarCubit>().views[state.index];
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.kWhiteColor,
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.s8,
            right: AppSizes.s8,
            bottom: AppSizes.s30,
            top: AppSizes.s8,
          ),
          child: GNav(
            selectedIndex: context.watch<NavBarCubit>().state.index,
            onTabChange: (index) {
              context.read<NavBarCubit>().changeTab(index);
            },
            rippleColor: AppColors.kPrimaryColor,
            hoverColor: AppColors.kPrimaryColor,
            haptic: true,
            tabBorderRadius: AppSizes.s20,
            curve: Curves.easeOutExpo,
            duration: Duration(milliseconds: 500),
            gap: 8,
            color: AppColors.kGreyColor,
            activeColor: AppColors.kWhiteColor,
            iconSize: AppSizes.s30,
            tabBackgroundColor: AppColors.kPrimaryColor,
            padding: EdgeInsets.symmetric(
                horizontal: AppSizes.s20, vertical: AppSizes.s5),
            tabs: [
              GButton(icon: LineIcons.home, text: 'Home'),
              GButton(icon: LineIcons.store, text: 'Store'),
              GButton(icon: LineIcons.heart, text: 'Likes'),
              GButton(icon: LineIcons.user, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
