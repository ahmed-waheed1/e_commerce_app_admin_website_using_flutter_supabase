import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.widget,
  });

  final VoidCallback? onPressed;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s16),
          ),
          foregroundColor: AppColors.kWhiteColor,
        ),
        onPressed: onPressed,
        child: widget ??
            Icon(
              Icons.arrow_forward,
              size: AppSizes.s20,
            ));
  }
}
