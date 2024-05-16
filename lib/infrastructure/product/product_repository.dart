import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mp_payment_client/domain/product/interface/i_product.dart';
import 'package:mp_payment_client/domain/product/model/product.dart';
import 'package:mp_payment_client/domain/response/models/response.dart';
import 'package:mp_payment_client/utils/api/api.dart';

class ProductRepository extends IProduct{
  @override
  Future<List<Product>> getAllProductsByBusiness(int businessID) async{
    try{
      final url = Uri.https(Api.getAPIBase(), '${Api.productByBusiness}/$businessID', {});
      final response = await http.get(
        url,
        headers: {
          'Content-Type' : 'application/json'
        }
      ).timeout(const Duration(milliseconds: Api.timeout));
      if (response.statusCode == 200) {
        CustomResponse customResponse = CustomResponse.fromJson(jsonDecode(response.body));
        List<Product> productList = List<Product>.from(
          customResponse.data.map((x) => Product.fromJson(x))
        );
        return productList;
      }
    }catch(e){
      Get.printError(
        info: 'An error has occurred: $e'
      );
    }
    return [];
  }

  @override
  Future<List<Product>> getPromotionalProductsByBusiness(int businessID) async{
    try{
      final url = Uri.https(Api.getAPIBase(), '${Api.promotionalProduct}/$businessID', {});
      final response = await http.get(
        url,
        headers: {
          'Content-Type' : 'application/json'
        }
      ).timeout(const Duration(milliseconds: Api.timeout));
      if (response.statusCode == 200) {
        CustomResponse customResponse = CustomResponse.fromJson(jsonDecode(response.body));
        List<Product> productList = List<Product>.from(
          customResponse.data.map((x) => Product.fromJson(x))
        );
        return productList;
      }
    }catch(e){
      Get.printError(
        info: 'An error has occurred: $e'
      );
    }
    return [];
  }
}