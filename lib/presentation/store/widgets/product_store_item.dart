import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/domain/product/model/product.dart';
import 'package:mp_payment_client/presentation/store/controllers/store_controller.dart';
import 'package:mp_payment_client/utils/api/api.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';
import 'package:mp_payment_client/utils/utils.dart';

class ProductStoreItem extends StatelessWidget {

  final Product product;

  ProductStoreItem({
    super.key,
    required this.product
  });

  final StoreController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 1.6,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Column(
                    children: [
                      product.image == ""
                        ? const Icon(
                            Icons.inventory_2_outlined,
                            color: CustomColors.secundaryColor,
                            size: 140,
                          )
                        : CachedNetworkImage(
                            imageUrl: product.image,
                            fit: BoxFit.cover,
                            height: 140,
                            placeholder: (context, url){
                              return const SizedBox(
                                width: 140,
                                height: 140,
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
                                size: 140,
                              );
                            },
                        ),
                      
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6, left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        style: CustomTextStyles.paragraph(
                          color: CustomColors.secundaryColor,
                          isBold: true
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product.description,
                        style: CustomTextStyles.smallParagraph(
                          color: CustomColors.secundaryColor
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                          controller.decreaseAmount(product);
                        },
                        child: Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: CustomColors.mainColor,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.remove_outlined,
                              color: CustomColors.secundaryColor,
                              size: 22,
                            ),
                          )
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              'IVA: ${product.tax.toStringAsFixed(2)}%',
                              style: CustomTextStyles.smallParagraph(
                                color: CustomColors.secundaryColor
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              Utils.getCurrencyFormat(
                                product.price + 
                                (product.tax > 0 
                                ? (product.tax/100) * product.price
                                : 0 )),
                              overflow: TextOverflow.ellipsis,
                              style: product.price.toString().length < 6
                              ? CustomTextStyles.paragraph(
                                  isBold: true,
                                  color: CustomColors.secundaryColor,
                                  lineThrough: product.discount > 0
                                )
                              : CustomTextStyles.smallParagraph(
                                  isBold: true,
                                  color: CustomColors.secundaryColor,
                                  lineThrough: product.discount > 0
                                )
                            ),
                            if(product.discount > 0)
                            Text(
                              Utils.getCurrencyFormat(
                                product.price - (product.price * (product.discount/100)) + 
                                (product.tax > 0 
                                ? (product.tax/100) * (product.price - (product.price * (product.discount/100)))
                                : 0 )),
                              overflow: TextOverflow.ellipsis,
                              style: product.price.toString().length < 6
                              ? CustomTextStyles.paragraph(
                                  color: CustomColors.dangerColor,
                                  isBold: true
                                )
                              : CustomTextStyles.smallParagraph(
                                  color: CustomColors.dangerColor,
                                  isBold: true
                                )
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                          controller.addAmount(product);
                        },
                        child: Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: CustomColors.mainColor,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add_outlined,
                              color: CustomColors.secundaryColor,
                              size: 22,
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.productsCart.keys.any(
              (element) => element.id == product.id),
            child: Positioned(
              right: 0,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: CustomColors.mainColor,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Center(
                  child:  Text(
                    controller.getProductQuantity(product.id),
                    style: CustomTextStyles.paragraph(
                      color: CustomColors.secundaryColor,
                      isBold: true
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: product.discount > 0,
          child: Positioned(
            left: 0,
            child: Container(
              width: 58,
              height: 34,
              decoration: BoxDecoration(
                color: CustomColors.dangerColor,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Center(
                child:  FittedBox(
                  child: Text(
                    '-${product.discount}%',
                    style: CustomTextStyles.smallParagraph(
                      isBold: true,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}