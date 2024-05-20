import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/domain/business/model/business.dart';
import 'package:mp_payment_client/domain/product/model/product.dart';
import 'package:mp_payment_client/presentation/main/controllers/main_controller.dart';
import 'package:mp_payment_client/presentation/store/controllers/store_controller.dart';
import 'package:mp_payment_client/presentation/store/screens/store_screen.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';
import 'package:mp_payment_client/utils/utils.dart';

class ProductItem extends StatelessWidget {
  ProductItem({
    super.key,
    required this.product,
  });

  final Product product;
  final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () async{
        Business business = controller.business.firstWhere((b) => b.id == product.businessID);
        if(Get.isRegistered<StoreController>()) {
          final storeController = Get.find<StoreController>();
          storeController.businessInfo.id == business.id
          ? storeController.productsCart.clear()
          : await Get.delete<StoreController>();
        }
        Get.put(
          StoreController(
            businessInfo: business
          )
        );
        Get.to(() => StoreScreen());
      },
      child: Container(
        height: 154,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: CustomTextStyles.paragraph(
                        color: CustomColors.secundaryColor,
                        isBold: true
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.description,
                      style: CustomTextStyles.paragraph(
                        color: CustomColors.secundaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: CustomColors.tertiaryColor
                            ),
                            child: Center(
                              child: Text(
                                Utils.getCurrencyFormat(
                                product.price - (product.price * (product.discount/100)) + 
                                (product.tax > 0 
                                ? (product.tax/100) * (product.price - (product.price * (product.discount/100)))
                                : 0 )),
                                style: CustomTextStyles.paragraph(
                                  color: CustomColors.secundaryColor,
                                  isBold: true
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: 22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: CustomColors.mainColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.discount,
                                    color: CustomColors.secundaryColor,
                                    size: 14,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${product.discount.toStringAsFixed(2)}%',
                                    style: CustomTextStyles.smallParagraph(
                                      color: CustomColors.secundaryColor,
                                      isBold: true
                                    ),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            height: 22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: CustomColors.quaternaryColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.touch_app,
                                    color: CustomColors.secundaryColor,
                                    size: 14,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Ir a la tienda',
                                    style: CustomTextStyles.smallParagraph(
                                      color: CustomColors.secundaryColor,
                                      isBold: true
                                    ),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    product.image == ""
                    ? const Icon(
                        Icons.inventory_2_outlined,
                        color: CustomColors.secundaryColor,
                        size: 115,
                      )
                    : Center(
                      child: CachedNetworkImage(
                          imageUrl: product.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url){
                            return const SizedBox(
                              height: 115,
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
                              size: 115,
                            );
                          },
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () async{
                          await controller.saveFavoriteProduct(product.id);
                        },
                        child: Obx(
                          () => Icon(
                            controller.favoriteProducts.contains(product.id)
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                            color: controller.favoriteProducts.contains(product.id)
                            ? CustomColors.dangerColor
                            : CustomColors.secundaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}