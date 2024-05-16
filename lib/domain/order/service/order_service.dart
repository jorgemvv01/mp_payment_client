import 'package:mp_payment_client/domain/order/interface/i_order.dart';
import 'package:mp_payment_client/domain/order/model/order.dart';
import 'package:mp_payment_client/domain/order/model/order_detail.dart';
import 'package:mp_payment_client/domain/order/model/order_payment.dart';
import 'package:mp_payment_client/domain/order/model/order_request.dart';

class OrderService {
  final IOrder iOrder;

  OrderService({
    required this.iOrder
  });

  Future<Order?> createOrder(OrderRequest orderRequest) async {
    return await iOrder.createOrder(orderRequest);
  }

  Future<List<Order>> getOrdersByUser(int userID) async {
    return await iOrder.getOrdersByUser(userID);
  }

  Future<List<OrderDetail>> getOrderDetails(int orderID) async {
    return await iOrder.getOrderDetails(orderID);
  }

  Future<OrderPayment?> getOrderPayment(int orderID) async {
    return await iOrder.getOrderPayment(orderID);
  }
}