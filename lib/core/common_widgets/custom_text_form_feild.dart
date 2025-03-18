import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_sizes.dart';

class CustomTextFormFeild extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final Function()? onTap;
  const CustomTextFormFeild({
    super.key,
    this.labelText = '',
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: suffixIcon,
        border: getTextFormStyle(),
        focusedBorder: getTextFormStyle(),
        enabledBorder: getTextFormStyle(),
      ),
    );
  }

  OutlineInputBorder getTextFormStyle() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.kBordersideColor,
        width: AppSizes.s2,
      ),
      borderRadius: BorderRadius.circular(AppSizes.s8),
    );
  }
}
