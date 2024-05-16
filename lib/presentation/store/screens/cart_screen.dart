import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/presentation/store/controllers/store_controller.dart';
import 'package:mp_payment_client/presentation/store/widgets/product_cart.dart';
import 'package:mp_payment_client/presentation/store/widgets/total_order_text.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';
import 'package:mp_payment_client/utils/utils.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final StoreController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secundaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: (){
                    Get.close(1);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: CustomColors.mainColor,
                  )
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Carrito',
                  style: CustomTextStyles.titleH3(isBold: true),
                ),
              ],
            ),
            Expanded(
              flex: 3,
              child: Obx(
                () => ListView.builder(
                  physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast
                  ),
                  itemCount: controller.productsCart.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCart(
                      product: controller.productsCart.keys.elementAt(index),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(
                      () => TotalOrderTexts(
                        label: 'Subtotal + IVA:',
                        description: Utils.getCurrencyFormat(controller.subtotal.value),
                      ),
                    ),
                    Obx(
                      () => TotalOrderTexts(
                        label: 'IVA:',
                        description: Utils.getCurrencyFormat(controller.tax.value),
                      ),
                    ),
                    Obx(
                      () => TotalOrderTexts(
                        label: 'Descuento:',
                        description: Utils.getCurrencyFormat(controller.discount.value),
                      ),
                    ),
                    Obx(
                      () => TotalOrderTexts(
                        label: 'Total:',
                        description: Utils.getCurrencyFormat(controller.total.value),
                        labelIsBold: true,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 18.0),
              child: Obx(
                () => Visibility(
                  visible: controller.productsCart.isNotEmpty,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: CustomColors.mainColor,
                        foregroundColor: CustomColors.secundaryColor,
                        splashFactory: NoSplash.splashFactory,
                        shadowColor: null,
                        surfaceTintColor: null
                      ),
                      child: Text(
                        'Crear pedido',
                        style: CustomTextStyles.titleH5(
                          color: CustomColors.secundaryColor,
                          isBold: true
                        ),
                      ),
                      onPressed: ()async{
                        await controller.createOrder();
                      }
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}