import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/presentation/main/controllers/main_controller.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';

class StoreItemWG extends StatelessWidget {
  StoreItemWG({
    super.key,
    required this.title,
    required this.index
  });

  final int index;
  final String title;
  final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () async{
        if (controller.isProductsLoading.value) return;
        controller.selectedBusinessIndex.value = index;
        await controller.getPromotionalProductsByBusiness();
      },
      child: Obx(
        () => Container(
          width: title.length * 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: controller.selectedBusinessIndex.value == index
            ? CustomColors.mainColor
            : Colors.white
          ),
          child: Center(
            child: Text(
              controller.business[index].name,
              style: CustomTextStyles.paragraph(
                isBold: true,
                color: CustomColors.secundaryColor
              ),
            ),
          ),
        ),
      ),
    );
  }
}