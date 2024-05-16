import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/presentation/my_orders/controllers/my_orders_controller.dart';
import 'package:mp_payment_client/presentation/my_orders/widgets/order_item.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';
import 'package:mp_payment_client/utils/widgets/no_record_found/no_record_found.dart';

class MyOrdesScreen extends StatelessWidget {
  MyOrdesScreen({
    super.key,
  });

  final MyOrdersController controller = Get.put(MyOrdersController());

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
                  'Mis Compras',
                  style: CustomTextStyles.titleH3(isBold: true),
                ),
              ],
            ),
             Expanded(
               child: Obx(() => controller.myOrders.isEmpty 
                  && !controller.isLoading.value
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NoRecordFound(),
                        const SizedBox(height: 40,)
                      ],
                    )
                  )
                  : RefreshIndicator(
                    backgroundColor: CustomColors.mainColor,
                    color: CustomColors.secundaryColor,
                    onRefresh: controller.getMyOrders,
                    child: ListView.builder(
                      itemCount: controller.myOrders.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                          child: OrderItem(
                            order: controller.myOrders[index]
                          ),
                        );
                      },
                    ),
                  ),
               ),
             )
          ],
        ),
      ),
    );
  }
}