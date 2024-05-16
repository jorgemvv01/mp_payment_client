import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/presentation/store/controllers/store_controller.dart';
import 'package:mp_payment_client/presentation/store/screens/cart_screen.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';

class ShoppingCart extends StatelessWidget {
  ShoppingCart({
    super.key,
  });

  final StoreController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (controller.getAddedProducts() > 0) {
          Get.to(() => CartScreen());
        }
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Center(
        child: SizedBox(
          width: 70,
          child: Stack(
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                size: 38,
                color: Colors.white,
              ),
              Obx(
                () => Visibility(
                  visible: controller.getAddedProducts() > 0,
                  child: Positioned(
                    top: -2,
                    right: 5,
                    child: Container(
                      width: 40,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.red.withOpacity(0.92),
                      ),
                      child: Center(
                        child: Text(
                          controller.getAddedProducts() > 1000
                          ? '+1000'
                          : controller.getAddedProducts().toString(),
                          style: CustomTextStyles.smallParagraph(
                            color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}