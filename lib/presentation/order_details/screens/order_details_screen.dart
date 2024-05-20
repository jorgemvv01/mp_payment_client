import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mp_payment_client/domain/order/model/order.dart';
import 'package:mp_payment_client/presentation/main/controllers/main_controller.dart';
import 'package:mp_payment_client/presentation/mercadopago/screens/mercadopago_screen.dart';
import 'package:mp_payment_client/presentation/order_details/controllers/order_details_controller.dart';
import 'package:mp_payment_client/presentation/order_details/widgets/order_details_item.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';
import 'package:mp_payment_client/utils/utils.dart';
import 'package:mp_payment_client/utils/widgets/alerts/custom_alerts.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  OrderDetailsScreen({
    required this.order,
    super.key,
  });

  final OrderDetailsController controller = Get.find();
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secundaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
                      'Compra #${order.id}',
                      style: CustomTextStyles.titleH3(isBold: true),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal + IVA:',
                            style: CustomTextStyles.paragraph(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            Utils.getCurrencyFormat(order.subtotal),
                            style: CustomTextStyles.paragraph(isBold: true),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'IVA:',
                            style: CustomTextStyles.paragraph(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            Utils.getCurrencyFormat(order.tax),
                            style: CustomTextStyles.paragraph(isBold: true),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Descuento:',
                            style: CustomTextStyles.paragraph(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            Utils.getCurrencyFormat(order.discount),
                            style: CustomTextStyles.paragraph(isBold: true),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: CustomTextStyles.paragraph(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            Utils.getCurrencyFormat(order.total),
                            style: CustomTextStyles.paragraph(isBold: true),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Productos',
                        style: CustomTextStyles.titleH4(isBold: true),
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
            Expanded(
              child: Obx(
                () => RefreshIndicator(
                  onRefresh: controller.getOrderDetails,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.orderDetails.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                        child: OrderDetailsItem(
                          orderDetail: controller.orderDetails[index]
                        ),
                      );
                    },
                  ),
                ),
              )
            ),
            Obx(
              () => Visibility(
                visible: !controller.isLoading.value,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: controller.orderPayment.isNotEmpty
                    ? Column(
                      children: [
                        Center(
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Pago realizado',
                                  style: CustomTextStyles.titleH4(isBold: true),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.check_circle_outlined,
                                  size: 30,
                                  color: CustomColors.mainColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ID:',
                              style: CustomTextStyles.titleH5(),
                            ),
                            Text(
                              '${controller.orderPayment[0].paymentId}',
                              style: CustomTextStyles.titleH5(isBold: true),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Estado:',
                              style: CustomTextStyles.titleH5(),
                            ),
                            Text(
                              controller.orderPayment[0].status,
                              style: CustomTextStyles.titleH5(isBold: true),
                            )
                          ],
                        )
                      ],
                    )
                    : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.info_outline,
                              size: 45,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: Get.width * 0.65,
                              child: Text(
                                'No se encontró información de pago realizado.',
                                style: CustomTextStyles.paragraph(isBold: true),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        order.mpInitPoint == ""
                        ? Text(
                            '''No se encontró preferencia de pago. Intente crear nuevamente el pedido.''',
                            style: CustomTextStyles.titleH5(isBold: true, color: CustomColors.warningColor),
                            maxLines: 2,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                          )
                        : InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: ()async{
                              mainController.mpInitPoint = order.mpInitPoint;          
                              if(await InternetConnectionChecker().hasConnection){
                                Get.to(() => MercadopagoScreen());
                                return;
                              }
                              CustomAlerts.generalDialog(
                                'Error',
                                'No hay conexión a internet',
                                onAcceptPressed: () => Get.close(1),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF009ee3),
                              ),
                              child: Center(
                                child: Text(
                                  'Pagar con Mercado Pago',
                                  style: CustomTextStyles.titleH4(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                ),
              ),
            ),
            const SizedBox(height: 20)
          ]
        ),
      ),
    );
  }
}