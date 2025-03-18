import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/style_manager.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const CustomTextButton({
    super.key,
    this.text = AppStrings.forgotPassword,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: getRegularStyle(
          color: AppColors.kPrimaryColor,
          fontSize: AppSizes.s16,
        ),
      ),
    );
  }
}
