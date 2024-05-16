import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/domain/order/model/order.dart';
import 'package:mp_payment_client/presentation/order_details/controllers/order_details_controller.dart';
import 'package:mp_payment_client/presentation/order_details/screens/order_details_screen.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';
import 'package:mp_payment_client/utils/utils.dart';

class OrderItem extends StatelessWidget {

  final Order order;
  const OrderItem({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async{
        if(Get.isRegistered<OrderDetailsController>()){
          await Get.delete<OrderDetailsController>();
        }
        Get.put(OrderDetailsController(order: order));
        Get.to(() => OrderDetailsScreen(order: order,));
      },
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: Center(
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 48,
                  color: CustomColors.secundaryColor,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'ID: ',
                              style: CustomTextStyles.paragraph(
                                color: CustomColors.secundaryColor,
                                isBold: true
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${order.id}',
                                style: CustomTextStyles.paragraph(
                                  color: CustomColors.secundaryColor
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Subtotal + IVA: ${Utils.getCurrencyFormat(order.subtotal)}',
                          style: CustomTextStyles.smallParagraph(
                            color: CustomColors.secundaryColor
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'IVA: ${Utils.getCurrencyFormat(order.tax)}',
                          style: CustomTextStyles.smallParagraph(
                            color: CustomColors.secundaryColor
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Descuento: ${Utils.getCurrencyFormat(order.discount)}',
                          style: CustomTextStyles.smallParagraph(
                            color: CustomColors.secundaryColor
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Total: ${Utils.getCurrencyFormat(order.total)}',
                          style: CustomTextStyles.smallParagraph(
                            color: CustomColors.secundaryColor
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12)
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: <Color>[
                            CustomColors.mainColor,
                            Colors.white
                          ],
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: CustomColors.secundaryColor,
                      ),
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}