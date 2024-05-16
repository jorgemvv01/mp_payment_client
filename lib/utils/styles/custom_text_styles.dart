import 'package:flutter/material.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';

class CustomTextStyles {
  static TextStyle titleH1(
      {Color color = Colors.white, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'Poppins',
      fontSize: 32,
    );
  }

  static TextStyle titleH2(
      {Color color = Colors.white, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'Poppins',
      fontSize: 26,
    );
  }

  static TextStyle titleH3(
      {Color color = Colors.white, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'Poppins',
      fontSize: 22,
    );
  }

  static TextStyle titleH4(
      {Color color = Colors.white, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'Poppins',
      fontSize: 18,
    );
  }

  static TextStyle titleH5(
      {Color color = Colors.white, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'Poppins',
      fontSize: 16,
    );
  }

  static TextStyle titleH6(
      {Color color = Colors.white, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'Poppins',
      fontSize: 14,
    );
  }

  static TextStyle paragraph(
      {Color color = Colors.white, bool isBold = false, bool lineThrough = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'Poppins',
      fontSize: 15,
      decoration: lineThrough ? TextDecoration.lineThrough : null
    );
  }

  static TextStyle smallParagraph(
      {Color color = Colors.white, bool isBold = false, bool lineThrough = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'Poppins',
      fontSize: 13,
      decoration: lineThrough ? TextDecoration.lineThrough : null
    );
  }
}
