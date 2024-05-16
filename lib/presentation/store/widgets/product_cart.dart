import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/domain/product/model/product.dart';
import 'package:mp_payment_client/presentation/store/controllers/store_controller.dart';
import 'package:mp_payment_client/presentation/store/widgets/quantity_product_card.dart';
import 'package:mp_payment_client/utils/api/api.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';
import 'package:mp_payment_client/utils/utils.dart';

class ProductCart extends StatelessWidget {

  final Product product;

  ProductCart({
    super.key,
    required this.product
  });

  final StoreController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              width: double.infinity,
              height: 125,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 90,
                          child: product.image == ""
                            ? const Icon(
                                Icons.inventory_2_outlined,
                                color: CustomColors.secundaryColor,
                                size: 90,
                              )
                            : CachedNetworkImage(
                                imageUrl: product.image,
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
                      const SizedBox(width: 10,),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                color: CustomColors.secundaryColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Utils.getCurrencyFormat(
                                    product.price + 
                                    (product.tax > 0 
                                    ? (product.tax/100) * product.price
                                    : 0 )),
                                  style: product.price.toString().length < 6
                                  ? CustomTextStyles.paragraph(
                                      color: CustomColors.secundaryColor,
                                      isBold: true,
                                      lineThrough: product.discount > 0
                                    )
                                  : CustomTextStyles.smallParagraph(
                                      color: CustomColors.secundaryColor,
                                      isBold: true,
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
                            Visibility(
                              visible: product.discount > 0,
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
                          ],
                        )
                      ),
                      Expanded(
                        flex: 2,
                        child: ProductQuantityCard(
                          product: product,
                          quantityController: TextEditingController(
                            text: controller.productsCart[product]!.toString()
                          ),
                          onSubmitted: (value){
                            controller.addQuantity(product, value);
                          },
                        )
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: (){
                controller.productsCart.remove(product);
                controller.calculateTotal();
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: CustomColors.dangerColor,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}