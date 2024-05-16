import 'package:get/get.dart';
import 'package:mp_payment_client/domain/order/model/order.dart';
import 'package:mp_payment_client/domain/order/service/order_service.dart';
import 'package:mp_payment_client/infrastructure/order/order_repository.dart';
import 'package:mp_payment_client/utils/widgets/alerts/custom_alerts.dart';

class MyOrdersController extends GetxController{

  RxList<Order> myOrders = <Order>[].obs;
  final RxBool isLoading = false.obs;
  final OrderService orderService = OrderService(iOrder: OrderRepository());

  @override
  void onReady() {
    getMyOrders();
    super.onReady();
  }
  
  Future<void> getMyOrders() async{
    isLoading.value = true;
    CustomAlerts.loading();

    myOrders.value = await orderService.getOrdersByUser(1);
    isLoading.value = false;
    Get.close(1);
  }
}