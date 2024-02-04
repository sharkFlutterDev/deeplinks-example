import 'package:flutter/material.dart';

class ColorsUtils {
  static final Color primaryColor = HexColor("00BE74"); //
  static final Color secondaryColor = HexColor("ABB0B6");
  static final Color black = HexColor("#181818");
  static final Color white = HexColor("#FFFFFF");
  static final Color whiteBgColor = HexColor("#f9f9f9");
  static final Color homeBgColor = HexColor("#edeef0");
  static final Color grey = HexColor("#cdd1d4");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
