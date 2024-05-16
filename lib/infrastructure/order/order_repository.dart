import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mp_payment_client/domain/order/interface/i_order.dart';
import 'package:mp_payment_client/domain/order/model/order.dart';
import 'package:mp_payment_client/domain/order/model/order_detail.dart';
import 'package:mp_payment_client/domain/order/model/order_payment.dart';
import 'package:mp_payment_client/domain/order/model/order_request.dart';
import 'package:mp_payment_client/domain/response/models/response.dart';
import 'package:mp_payment_client/utils/api/api.dart';

class OrderRepository extends IOrder{
  @override
  Future<Order?> createOrder(OrderRequest orderRequest) async{
    try{
      final url = Uri.https(Api.getAPIBase(), Api.order, {});
      Object body = jsonEncode(orderRequest);
      final response = await http.post(
        url,
        headers: {
          'Content-Type' : 'application/json'
        },
        body: body
      ).timeout(const Duration(milliseconds: Api.timeout));
      if (response.statusCode == 201) {
        CustomResponse customResponse = CustomResponse.fromJson(jsonDecode(response.body));
        Order order = Order.fromJson(customResponse.data);
        return order;
      }
    }catch(e){
      Get.printError(
        info: 'An error has occurred: $e'
      );
    }
    return null;
  }

  @override
  Future<List<Order>> getOrdersByUser(int userID) async{
    List<Order> orders = [];
    try{
      final url = Uri.https(Api.getAPIBase(), '${Api.orderByUser}/$userID', {});
      final response = await http.get(
        url,
        headers: {
          'Content-Type' : 'application/json'
        },
      ).timeout(const Duration(milliseconds: Api.timeout));
      if (response.statusCode == 200) {
        CustomResponse customResponse = CustomResponse.fromJson(jsonDecode(response.body));
        orders = List<Order>.from(
          customResponse.data.map((x) => Order.fromJson(x))
        );
        return orders;
      }
    }catch(e){
      Get.printError(
        info: 'An error has occurred: $e'
      );
    }
    return orders;
  }

  @override
  Future<List<OrderDetail>> getOrderDetails(int orderID) async{
    List<OrderDetail> orderDetails = [];
    try{
      final url = Uri.https(Api.getAPIBase(), '${Api.orderDetails}/$orderID', {});
      final response = await http.get(
        url,
        headers: {
          'Content-Type' : 'application/json'
        },
      ).timeout(const Duration(milliseconds: Api.timeout));
      if (response.statusCode == 200) {
        CustomResponse customResponse = CustomResponse.fromJson(jsonDecode(response.body));
        orderDetails = List<OrderDetail>.from(
          customResponse.data.map((x) => OrderDetail.fromJson(x))
        );
        return orderDetails;
      }
    }catch(e){
      Get.printError(
        info: 'An error has occurred: $e'
      );
    }
    return orderDetails;
  }

  @override
  Future<OrderPayment?> getOrderPayment(int orderID) async{
    try{
      final url = Uri.https(Api.getAPIBase(), '${Api.orderPayment}/$orderID', {});
      final response = await http.get(
        url,
        headers: {
          'Content-Type' : 'application/json'
        },
      ).timeout(const Duration(milliseconds: Api.timeout));
      if (response.statusCode == 200) {
        CustomResponse customResponse = CustomResponse.fromJson(jsonDecode(response.body));
        OrderPayment orderPayment = OrderPayment.fromJson(customResponse.data);
        return orderPayment;
      }
    }catch(e){
      Get.printError(
        info: 'An error has occurred: $e'
      );
    }
    return null;
  }
}