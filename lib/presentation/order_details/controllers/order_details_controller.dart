import 'package:get/get.dart';
import 'package:mp_payment_client/domain/order/model/order.dart';
import 'package:mp_payment_client/domain/order/model/order_detail.dart';
import 'package:mp_payment_client/domain/order/model/order_payment.dart';
import 'package:mp_payment_client/domain/order/service/order_service.dart';
import 'package:mp_payment_client/infrastructure/order/order_repository.dart';
import 'package:mp_payment_client/utils/widgets/alerts/custom_alerts.dart';

class OrderDetailsController extends GetxController{
  final Order order;
  
  RxList<OrderDetail> orderDetails = <OrderDetail>[].obs;
  RxList<OrderPayment> orderPayment = <OrderPayment>[].obs;
  final RxBool isLoading = false.obs;
  
  final OrderService orderService = OrderService(iOrder: OrderRepository());

  OrderDetailsController({
    required this.order
  });

  @override
  void onReady() {
    getOrderDetails();
    super.onReady();
  }
  
  Future<void> getOrderDetails() async{
    isLoading.value = true;
    CustomAlerts.loading();

    orderDetails.value = await orderService.getOrderDetails(order.id);
    if(orderDetails.isNotEmpty){
      OrderPayment? orderPaymentData = await orderService.getOrderPayment(order.id);
      if (orderPaymentData != null) orderPayment.add(orderPaymentData);
    }
    isLoading.value = false;
    Get.close(1);
  }
}