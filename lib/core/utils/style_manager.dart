import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class StyleManager {
  static final String fontFamily = GoogleFonts.lexendDeca().fontFamily!;
}

abstract class FontWeightManager {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

abstract class FontSizeManager {
  static const double s8 = 8;
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s15 = 15;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s19 = 19;
  static const double s20 = 20;
  static const double s22 = 22;
  static const double s24 = 24;
  static const double s40 = 40;
}

TextStyle getExtraLightStyle(
    {double fontSize = FontSizeManager.s12, Color color = Colors.black}) {
  return TextStyle(
    fontFamily: StyleManager.fontFamily,
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeightManager.extraLight,
  );
}

TextStyle getRegularStyle({
  required Color color,
  required double fontSize,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: GoogleFonts.lexendDeca().fontFamily,
    fontWeight: FontWeight.w400,
  );
}

TextStyle getMediumStyle({
  required Color color,
  required double fontSize,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: GoogleFonts.lexendDeca().fontFamily,
    fontWeight: FontWeight.w500,
  );
}

TextStyle getLightStyle({
  required Color color,
  required double fontSize,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: GoogleFonts.lexendDeca().fontFamily,
    fontWeight: FontWeight.w300,
  );
}

TextStyle getSemiBoldStyle(
    {double fontSize = FontSizeManager.s12, Color color = Colors.black}) {
  return TextStyle(
    fontFamily: StyleManager.fontFamily,
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeightManager.semiBold,
  );
}

TextStyle getBoldStyle(
    {double fontSize = FontSizeManager.s12, Color color = Colors.black}) {
  return TextStyle(
    fontFamily: StyleManager.fontFamily,
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeightManager.bold,
  );
}
