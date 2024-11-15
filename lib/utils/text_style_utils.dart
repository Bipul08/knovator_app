import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_utils.dart';

class TextStyleManager {

  static TextStyle get titleStyle => GoogleFonts.gabarito(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: ColorManager.textPrimaryColor,
  );

  static TextStyle get postTitleStyle => GoogleFonts.aBeeZee(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: ColorManager.textPrimaryColor,
  );

  static TextStyle get postSubtitleStyle => GoogleFonts.poppins(
    color: ColorManager.textSecondaryColor,
    fontSize: 12,
  );

  static TextStyle get timerTextStyle => GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black54,
  );

  static TextStyle get errorMessageStyle => TextStyle(
    color: Colors.red,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get contentTextStyle => TextStyle(
    fontSize: 16,
    height: 1.5,
    color: ColorManager.textPrimaryColor,
  );
}

