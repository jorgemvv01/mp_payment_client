import 'package:flutter/material.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';

class NoRecordFound extends StatelessWidget {
  NoRecordFound({
    super.key,
    this.onPressed,
    this.showReload = false
  });

  bool showReload;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.info_outline_rounded,
          color: Colors.white,
        ),
        Text(
          'No se encontraron registros',
          style: CustomTextStyles.paragraph(),
        ),
        if(showReload)
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: CustomColors.mainColor,
            foregroundColor: CustomColors.secundaryColor,
            splashFactory: NoSplash.splashFactory,
            shadowColor: null,
            surfaceTintColor: null
          ),
          child: Text(
            'Recargar',
            style: CustomTextStyles.titleH5(
              color: CustomColors.secundaryColor,
              isBold: true
            ),
          ),
          onPressed: onPressed
        ),
      ],
    );
  }
}