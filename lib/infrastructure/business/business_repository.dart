import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mp_payment_client/domain/business/interface/i_business.dart';
import 'package:mp_payment_client/domain/business/model/business.dart';
import 'package:mp_payment_client/domain/response/models/response.dart';
import 'package:mp_payment_client/utils/api/api.dart';

class BusinessRepository extends IBusiness{
  @override
  Future<List<Business>> getAllBusiness() async{
    try{
      final url = Uri.https(Api.getAPIBase(), Api.business, {});
      final response = await http.get(
        url,
        headers: {
          'Content-Type' : 'application/json'
        }
      ).timeout(const Duration(milliseconds: Api.timeout));
      if (response.statusCode == 200) {
        CustomResponse customResponse = CustomResponse.fromJson(jsonDecode(response.body));
        List<Business> businessList = List<Business>.from(
          customResponse.data.map((x) => Business.fromJson(x))
        );
        return businessList;
      }
    }catch(e){
      Get.printError(
        info: 'An error has occurred: $e'
      );
    }
    return [];
  }
}