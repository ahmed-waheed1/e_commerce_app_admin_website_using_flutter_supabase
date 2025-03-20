import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/style_manager.dart';

class CustomProfileBtn extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const CustomProfileBtn({
    super.key,
    this.title = AppStrings.updateProfile,
    this.icon = Icons.person,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          color: AppColors.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.s16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: AppColors.kWhiteColor,
                  size: AppSizes.s20,
                ),
                const SizedBox(
                  width: AppSizes.s10,
                ),
                Text(
                  title,
                  style: getBoldStyle(
                    color: AppColors.kWhiteColor,
                    fontSize: AppSizes.s16,
                  ),
                ),
                const SizedBox(
                  width: AppSizes.s10,
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.kWhiteColor,
                  size: AppSizes.s20,
                ),
              ],
            ),
          )),
    );
  }
}
