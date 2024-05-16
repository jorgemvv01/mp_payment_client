import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_payment_client/presentation/main/controllers/main_controller.dart';
import 'package:mp_payment_client/presentation/main/screens/main_screen.dart';
import 'package:mp_payment_client/utils/widgets/alerts/custom_alerts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MercadopagoController extends GetxController{

  WebViewController controller = WebViewController();
  RxBool started = false.obs;
  RxBool finished = false.obs;
  RxBool hasError = false.obs;

  final MainController mainController = Get.find();

  @override
  void onInit() {
    controller
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.white)
    ..setNavigationDelegate(
        NavigationDelegate(

          onPageStarted: (String url) {
            if(!started.value){
              started.value = true;
              CustomAlerts.loading();
            }
          },
          onPageFinished: (String url) {
            if(!finished.value && started.value){
              finished.value = true;
              Get.close(1);
            }
          },
          onWebResourceError: (WebResourceError error) {
            if(!hasError.value && started.value){
              if(!finished.value) Get.close(1);
              hasError.value = true;
              CustomAlerts.generalDialog(
                'Error', 
                'No hay conexión a internet',
                onAcceptPressed: (){
                  Get.close(1);
                },
                acceptText: 'Reintentar después'
              );
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('mp.dev-jorgemvv01.online')) {
              CustomAlerts.generalDialog(
                'Advertencia', 
                '¿Estás seguro que deseas salir?',
                showCancelButton: true,
                onCancelPressed: () => Get.close(1),
                onAcceptPressed: () {
                  Get.offAll(() => MainScreen());
                }
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
    ..loadRequest(Uri.parse(mainController.mpInitPoint));
    super.onInit();
  }
}