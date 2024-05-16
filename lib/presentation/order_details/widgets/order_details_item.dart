import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mp_payment_client/domain/order/model/order_detail.dart';
import 'package:mp_payment_client/utils/api/api.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';
import 'package:mp_payment_client/utils/utils.dart';

class OrderDetailsItem extends StatelessWidget {

  final OrderDetail orderDetail;

  const OrderDetailsItem({
    super.key,
    required this.orderDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Center(
              child: SizedBox(
                height: 90,
                width: 92,
                child: orderDetail.product.image == ""
                    ? const Icon(
                          Icons.inventory_2_outlined,
                          color: CustomColors.secundaryColor,
                          size: 90,
                        )
                    : CachedNetworkImage(
                        imageUrl: orderDetail.product.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url){
                          return const SizedBox(
                            width: 85,
                            height: 85,
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: CustomColors.mainColor,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                        errorWidget: (_, __, ___) {
                          return const Icon(
                            Icons.inventory_2_outlined,
                            color: CustomColors.secundaryColor,
                            size: 90,
                          );
                        },
                    ),
                 
                ),
              ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    orderDetail.product.name,
                    style: CustomTextStyles.paragraph(
                      color: CustomColors.secundaryColor,
                      isBold: true
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Cantidad: ${orderDetail.quantity}',
                    style: CustomTextStyles.paragraph(
                      color: CustomColors.secundaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Precio: ${Utils.getCurrencyFormat(orderDetail.price)}',
                    style: CustomTextStyles.paragraph(
                      color: CustomColors.secundaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Visibility(
                    visible: orderDetail.discount > 0,
                    child: Container(
                      width: 58,
                      height: 22,
                      decoration: BoxDecoration(
                        color: CustomColors.dangerColor,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child:  FittedBox(
                          child: Text(
                            '-${orderDetail.discount.toStringAsFixed(2)}%',
                            style: CustomTextStyles.smallParagraph(
                              isBold: true,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
