import 'package:flutter/material.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';

class CustomTextButton extends StatelessWidget {

  final String label;
  final Color? color;
  final double fontSize;
  final bool isBold;
  final IconData? icon;
  final Color? iconColor;
  final void Function() onPressed;

  const CustomTextButton({
    super.key,
    required this.label,
    this.color,
    this.fontSize = 15,
    this.isBold = true,
    this.icon,
    this.iconColor,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          if(icon != null)
          Icon(
            icon,
            color: color ?? CustomColors.mainColor,
          ),
          Text(
            label,
            style: TextStyle(
              color: color ?? Colors.white,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'Poppins',
              fontSize: fontSize,
            )
          ),
        ],
      ),
    );
  }
}