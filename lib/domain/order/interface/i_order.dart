import 'package:mp_payment_client/domain/order/model/order.dart';
import 'package:mp_payment_client/domain/order/model/order_detail.dart';
import 'package:mp_payment_client/domain/order/model/order_payment.dart';
import 'package:mp_payment_client/domain/order/model/order_request.dart';

abstract class IOrder {
  Future<Order?> createOrder(OrderRequest orderRequest);
  Future<List<Order>> getOrdersByUser(int userID);
  Future<List<OrderDetail>> getOrderDetails(int orderID);
  Future<OrderPayment?> getOrderPayment(int orderID);
}