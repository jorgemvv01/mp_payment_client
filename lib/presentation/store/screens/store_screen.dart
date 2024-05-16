import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/presentation/store/controllers/store_controller.dart';
import 'package:mp_payment_client/presentation/store/widgets/product_store_item.dart';
import 'package:mp_payment_client/presentation/store/widgets/shopping_cart.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';
import 'package:mp_payment_client/utils/widgets/no_record_found/no_record_found.dart';

class StoreScreen extends StatelessWidget {

  StoreScreen({
    super.key
  });

  final StoreController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secundaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      controller.businessInfo.name,
                      style: CustomTextStyles.titleH3(isBold: true),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ShoppingCart(),
                )
              ],
            ),
            const SizedBox(height: 9.0),
            Obx(
              () => controller.products.isEmpty 
              && !controller.isLoading.value
              ? Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: NoRecordFound(),
              )
              : Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.getProducts,
                  backgroundColor: CustomColors.mainColor,
                  color: CustomColors.secundaryColor,
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.products.length,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 300,
                    ),
                    itemBuilder: (context, index) {
                      return ProductStoreItem(
                        product: controller.products[index],
                      );
                    },
                  ),
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}