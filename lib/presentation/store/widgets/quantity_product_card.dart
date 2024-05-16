import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/domain/product/model/product.dart';
import 'package:mp_payment_client/presentation/store/controllers/store_controller.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';

class ProductQuantityCard extends StatelessWidget {

  final TextEditingController quantityController;
  final Product product;
  final void Function(String)? onSubmitted;

  ProductQuantityCard({
    super.key,
    required this.product,
    required this.quantityController,
    this.onSubmitted
  });

  final StoreController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: const Icon(
            Icons.remove_outlined,
            color: CustomColors.secundaryColor,
          ),
          onTap: () => controller.decreaseAmount(product),
        ),
        SizedBox(
          width: double.infinity,
          height: 30,
          child:TextField(
            enabled: true,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.top,
            maxLength: 4,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
            style: CustomTextStyles.paragraph(
              color: CustomColors.secundaryColor,
              isBold: true
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0.0,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0.0
                ),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              floatingLabelStyle: CustomTextStyles.titleH3(isBold: true),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.white,
            ),
            controller: quantityController,
            onSubmitted: onSubmitted,
          ),
        ),
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: const Icon(
            Icons.add_outlined,
            color: CustomColors.secundaryColor,
          ),
          onTap: () => controller.addAmount(product),
        )
      ],
    );
  }
}