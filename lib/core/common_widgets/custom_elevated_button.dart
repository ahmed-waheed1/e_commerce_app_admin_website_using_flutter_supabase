import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_sizes.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.widget,
    this.borderSize = AppSizes.s8,
  });

  final VoidCallback? onPressed;
  final Widget? widget;
  final double borderSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderSize),
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
