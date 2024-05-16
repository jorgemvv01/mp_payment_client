import 'package:flutter/material.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';

class TotalOrderTexts extends StatelessWidget {

  final String label;
  final String description;
  final bool labelIsBold;

  const TotalOrderTexts({
    super.key,
    required this.label,
    required this.description,
    this.labelIsBold = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          Text(
            label,
            style: CustomTextStyles.titleH4(isBold: labelIsBold),
          ),
          const SizedBox(width: 30,),
          Text(
            description,
            style: CustomTextStyles.titleH4(isBold: true),
          ),
        ],
      ),
    );
  }
}