import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';
import 'package:mp_payment_client/utils/widgets/buttons/custom_button.dart';

class CustomAlerts {

  static SnackbarController warningDialog(String message){
    return Get.snackbar(
      'Advertencia',
      message,
      icon: const Icon(
        Icons.error_outline_outlined,
        size: 32,
      color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: CustomColors.warningColor,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(milliseconds: 2500),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static loading({String text = ''}){
    return Get.dialog(
      WillPopScope(
        onWillPop: () async{
          return false;
        },
        child: Material(
          color: Colors.white.withOpacity(0.05),
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 6.0,
              color: CustomColors.mainColor,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      )
    );
  }

  static generalDialog(
    String title, 
    String message, {
    String? acceptText,
    bool showCancelButton = false,
    bool allowToBack = false,
    Widget? bottomWidget,
    void Function()? onCancelPressed,
    void Function()? onAcceptPressed
  }){
    return Get.dialog(
      WillPopScope(
        onWillPop: () async{
          return allowToBack;
        },
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          backgroundColor: CustomColors.secundaryColor,
          titlePadding: EdgeInsets.zero,
          title: Container(
            height: 60,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12)
              ),
              color: CustomColors.mainColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Center(
                child: Text(
                  title,
                  style: CustomTextStyles.titleH3(
                    color: CustomColors.secundaryColor,
                    isBold: true
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          content: SizedBox(
            height: 160,
            width: Get.width,
            child: Column(
              children: [
                SizedBox(
                  height: 110,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      message,
                      style: CustomTextStyles.titleH4(
                        color: Colors.white
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                bottomWidget != null
                ? SizedBox(child: bottomWidget)
                : FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: showCancelButton,
                        child: Row(
                          children: [
                            CustomTextButton(
                              label: 'Cancelar',
                              color: Colors.white,
                              fontSize: 20,
                              iconColor: Colors.white,
                              onPressed: onCancelPressed ?? (){}
                            ),
                            const SizedBox(width: 30)
                          ],
                        ),
                      ),
                      CustomTextButton(
                        label: acceptText ?? 'Aceptar',
                        color: Colors.white,
                        fontSize: 20,
                        iconColor: Colors.white,
                        onPressed: onAcceptPressed ?? (){}
                      )
                    ],
                  ),
                )
              ] 
            ),
          ),
        ),
      )
    );
  }

  // static mercadoPagoDialog(
  //   String title,
  //   void Function()? onTap
  // ){
  //   return Get.dialog(
  //     WillPopScope(
  //       onWillPop: () async{
  //         return false;
  //       },
  //       child: AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(30)
  //         ),
  //         backgroundColor: CustomColors.quaternaryColor,
  //         titlePadding: EdgeInsets.zero,
  //         title: Container(
  //           height: 60,
  //           decoration: const BoxDecoration(
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(25),
  //               topRight: Radius.circular(25)
  //             ),
  //             color: Color(0xFF2b3276),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 14.0),
  //             child: Center(
  //               child: Text(
  //                 title,
  //                 style: CustomTextStyles.titleH3(
  //                   isBold: true,
  //                   color: Colors.white
  //                 ),
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ),
  //           ),
  //         ),
  //         content: SizedBox(
  //           height: 180,
  //           width: Get.width,
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: 125,
  //                 width: double.infinity,
  //                 child: Center(
  //                   child: Image.asset(
  //                     CustomImages.mercadoPagoLogo
  //                   ),
  //                 ),
  //               ),
  //               InkWell(
  //                 splashColor: Colors.transparent,
  //                 highlightColor: Colors.transparent,
  //                 onTap: onTap,
  //                 child: Container(
  //                   width: double.infinity,
  //                   height: 45,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     color: Color(0xFF009ee3),
  //                   ),
  //                   child: Center(
  //                     child: Text(
  //                       GeneralTexts.texts.pay,
  //                       style: CustomTextStyles.titleH3(
  //                         color: Colors.white
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             ] 
  //           ),
  //         ),
  //       ),
  //     )
  //   );
  // }
}