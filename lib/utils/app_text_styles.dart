import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static List<int> fontSizes = List.generate(25, (index) => index + 8);

  static Map<int, TextStyle Function(FontWeight, Color)> lato = {
    for (var size in fontSizes)
      size: (weight, color) => GoogleFonts.lato(
          fontSize: size.toDouble(), fontWeight: weight, color: color),
  };

  static TextStyle getLato(double size, FontWeight weight,
      [Color color = Colors.black]) {
    if (lato.containsKey(size)) {
      return lato[size]!(weight, color);
    } else {
      return GoogleFonts.rubik(
        fontSize: size,
        fontWeight: weight,
        color: color,
      );
    }
  }
}
