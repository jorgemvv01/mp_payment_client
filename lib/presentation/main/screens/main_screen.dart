import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/presentation/main/controllers/main_controller.dart';
import 'package:mp_payment_client/presentation/main/widgets/product_item.dart';
import 'package:mp_payment_client/presentation/main/widgets/store_item_wg.dart';
import 'package:mp_payment_client/presentation/my_orders/screens/my_orders_screen.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';
import 'package:mp_payment_client/utils/widgets/no_record_found/no_record_found.dart';

class MainScreen extends StatelessWidget {
  MainScreen({
    super.key,
  });

  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.secundaryColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bienvenido',
                        style: CustomTextStyles.titleH2(
                          isBold: true
                        ),
                      ),
                      Text(
                        'Descubre los mejores productos',
                        style: CustomTextStyles.paragraph(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: (){
                          Get.to(() => MyOrdesScreen());
                        }, 
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Mis compras',
                        style: CustomTextStyles.smallParagraph(),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              Text(
                'Tiendas:',
                style: CustomTextStyles.paragraph(),
              ),
              SizedBox(
                height: 40,
                child: Obx(
                  () => ListView.builder(
                    physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.business.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: StoreItemWG(
                          index: index,
                          title: controller.business[index].name,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Obx(
                  () => controller.isProductsLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: CustomColors.mainColor,
                      )
                    )
                  : controller.promotionalProduct.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NoRecordFound(
                              showReload: true,
                              onPressed: controller.getPromotionalProductsByBusiness,
                            ),
                            const SizedBox(height: 40,)
                          ],
                        )
                      )
                    : RefreshIndicator(
                        backgroundColor: CustomColors.mainColor,
                        color: CustomColors.secundaryColor,
                        onRefresh: controller.getPromotionalProductsByBusiness,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.promotionalProduct.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: ProductItem(product: controller.promotionalProduct[index])
                            );
                          },
                        ),
                      ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}