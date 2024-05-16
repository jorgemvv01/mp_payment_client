

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/presentation/main/screens/main_screen.dart';
import 'package:mp_payment_client/presentation/mercadopago/controllers/mercadopago_controller.dart';
import 'package:mp_payment_client/utils/colors/custom_colors.dart';
import 'package:mp_payment_client/utils/styles/custom_text_styles.dart';
import 'package:mp_payment_client/utils/widgets/alerts/custom_alerts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MercadopagoScreen extends StatelessWidget {
  MercadopagoScreen({super.key});

  final MercadopagoController controller = Get.put(MercadopagoController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        CustomAlerts.generalDialog(
          'Advertencia', 
          '¿Estás seguro que deseas salir?',
          showCancelButton: true,
          onCancelPressed: () => Get.close(1),
          onAcceptPressed: () {
            Get.offAll(() => MainScreen());
          }
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: CustomColors.secundaryColor,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
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
                          CustomAlerts.generalDialog(
                            'Advertencia', 
                            '¿Estás seguro que deseas salir?',
                            showCancelButton: true,
                            onCancelPressed: () => Get.close(1),
                            onAcceptPressed: () {
                              Get.offAll(() => MainScreen());
                            }
                          );
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
                        'Pasarela de pago',
                        style: CustomTextStyles.titleH3(isBold: true),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: WebViewWidget(
                  controller: controller.controller,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}