import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/style_manager.dart';
import 'custom_elevated_button.dart';

class LoginOptions extends StatelessWidget {
  final String text;
  final Widget? widget;
  final VoidCallback? onPressed;
  const LoginOptions({
    super.key,
    this.text = AppStrings.login,
    this.widget,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: getRegularStyle(
            color: AppColors.kBlackColor,
            fontSize: AppSizes.s22,
          ),
        ),
        CustomElevatedButton(onPressed: onPressed, widget: widget),
      ],
    );
  }
}
